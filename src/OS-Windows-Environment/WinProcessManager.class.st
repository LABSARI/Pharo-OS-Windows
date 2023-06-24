"
An utility class for external processes management.
"
Class {
	#name : #WinProcessManager,
	#superclass : #Object,
	#pools : [
		'WinTypes'
	],
	#category : #'OS-Windows-Environment-Processing'
}

{ #category : #accessing }
WinProcessManager class >> findProcessWithWindowName: aString [
	"Returns the process (WinProcess) of the window titled with aString. Returns nil if no process is 	found."

	| windowHandle ptc pid processHandle |
	windowHandle := self findWindow: nil name: aString.
	"Window not found."
	windowHandle isNull ifTrue: [ ^ nil ].
	ptc := FFIBackend current allocate: 4.
	self getWindowThreadProcess: windowHandle id: ptc.
	"Could not found process id from window."
	ptc isNull ifTrue: [ ^ nil ].
	pid := ptc uint32AtOffset: 0.
	ptc free.
	processHandle := self openProcess: 16r1f0fff inherit: 1 pid: pid.
	"Could not found process handle."
	processHandle isNull ifTrue: [ ^ nil ].

	^ WinProcess new setHandle: processHandle
]

{ #category : #'ffi-calls' }
WinProcessManager class >> findWindow: classNname name: string [

	| aWinProcessManager |
	aWinProcessManager := self new.

	^ aWinProcessManager
		  ffiCall:
		  #( HWND FindWindowA #( LPCSTR classNname , LPCSTR string ) )
		  library: 'User32.dll'
]

{ #category : #accessing }
WinProcessManager class >> getWindowThreadProcess: whnd id: pointerToDWORD [

	| aWinProcessManager |
	aWinProcessManager := self new.

	^ aWinProcessManager
		  ffiCall:
		  #( DWORD GetWindowThreadProcessId #( HWND whnd , LPDWORD pointerToDWORD ) )
		  library: 'User32.dll'
]

{ #category : #accessing }
WinProcessManager class >> openProcess: access inherit: inh pid: pid [

	^ self ffiCall:  #( HANDLE OpenProcess(DWORD access, bool inh, DWORD pid)) library: 'kernel32.dll'
]
