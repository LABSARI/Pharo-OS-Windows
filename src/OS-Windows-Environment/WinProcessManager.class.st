"
An utility class for external processes management.
"
Class {
	#name : #WinProcessManager,
	#superclass : #Object,
	#pools : [
		'WinBaseConstants',
		'WinTypes'
	],
	#category : #'OS-Windows-Environment-Processing'
}

{ #category : #accessing }
WinProcessManager class >> findProcessWithWindowName: aString [
	"Returns the process (WinProcess) of the window titled with aString. Returns nil if no process is 	found."

	| windowHandle ptc pid processHandle accessRights |
	windowHandle := self findWindow: nil name: aString.
	"Window not found."
	windowHandle isNull ifTrue: [ ^ nil ].
	ptc := FFIBackend current allocate: 4.
	self getWindowThreadProcess: windowHandle id: ptc.
	"Could not found process id from window."
	ptc isNull ifTrue: [ ^ nil ].
	pid := ptc uint32AtOffset: 0.
	ptc free.
	accessRights := (PROCESS_VM_OPERATION bitOr: PROCESS_VM_READ) bitOr:
		                PROCESS_VM_WRITE.
	processHandle := self
		                 openProcess: accessRights
		                 inherit: 1
		                 pid: pid.
	"Could not found process handle."
	processHandle isNull ifTrue: [ ^ nil ].

	^ WinProcess new setHandle: processHandle
]

{ #category : #'ffi-calls' }
WinProcessManager class >> findWindow: classNname name: string [

	^ self
		  ffiCall:
		  #( HWND FindWindowA #( LPCSTR classNname , LPCSTR string ) )
		  library: 'User32.dll'
]

{ #category : #'private - primitives' }
WinProcessManager class >> getModuleBaseName: processAdress module: module string: str size: size [

	^ self ffiCall: #(DWORD GetModuleBaseNameA(HANDLE processAdress, HANDLE module, char * str,DWORD size))
		  library: 'psapi.dll'
]

{ #category : #accessing }
WinProcessManager class >> getWindowThreadProcess: whnd id: pointerToDWORD [

	^ self
		  ffiCall:
		  #( DWORD GetWindowThreadProcessId #( HWND whnd , LPDWORD pointerToDWORD ) )
		  library: 'User32.dll'
]

{ #category : #accessing }
WinProcessManager class >> openProcess: access inherit: inh pid: pid [

	^ self ffiCall:  #( HANDLE OpenProcess(DWORD access, bool inh, DWORD pid)) library: 'kernel32.dll'
]

{ #category : #'ffi-calls' }
WinProcessManager class >> readProcessMemory: hProcess address: baseAddress buffer: buffer size: size nbBytesRead: numberOfBytesRead [
	"The handle (hProcess) must have PROCESS_VM_READ access to the process."
	^ self ffiCall:
		  #( BOOL ReadProcessMemory #( HANDLE hProcess , LPCVOID baseAddress
		        , LPVOID buffer , SIZE_T size , SIZE_T * numberOfBytesRead ) ) library: 'kernel32.dll'
]

{ #category : #'ffi-calls' }
WinProcessManager class >> writeProcessMemory: hProcess address: baseAddress buffer: buffer size: size nbBytesWritten: numberOfBytesWritten [
	"The handle (hProcess) must have PROCESS_VM_WRITE and PROCESS_VM_OPERATION access to the process."
	^ self ffiCall:
		  #( BOOL WriteProcessMemory #( HANDLE hProcess , LPCVOID baseAddress
		        , LPVOID buffer , SIZE_T size , SIZE_T * numberOfBytesWritten ) ) library: 'kernel32.dll'
]
