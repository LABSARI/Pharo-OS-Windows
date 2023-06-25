"
A WinProcessManagerTest is a test class for testing the behavior of WinProcessManager
"
Class {
	#name : #WinProcessManagerTest,
	#superclass : #TestCase,
	#instVars : [
		'vmProcess',
		'processManager'
	],
	#category : #'OS-Windows-Environment-Tests-Processing'
}

{ #category : #running }
WinProcessManagerTest >> defaultTestClass [

	^ WinProcessManager
]

{ #category : #running }
WinProcessManagerTest >> setUp [

	super setUp.
	vmProcess := WinProcess currentProcess.
	processManager := self defaultTestClass.
]

{ #category : #running }
WinProcessManagerTest >> tearDown [

	vmProcess autoRelease.
	super tearDown
]

{ #category : #running }
WinProcessManagerTest >> testReadProcessMemory [

	| address readValue sizeToRead return |
	sizeToRead := 4.
	address := FFIBackend current allocate: sizeToRead.
	readValue := FFIBackend current allocate: sizeToRead.
	address uint32AtOffset: 0 put: 42.
	readValue uint32AtOffset: 0 put: 0.
	return := processManager
		          readProcessMemory: vmProcess
		          address: address
		          buffer: readValue
		          size: sizeToRead
		          nbBytesRead: nil.

	self deny: return equals: false.
	self assert: (readValue uint32AtOffset: 0) equals: 42.
	address free.
	readValue free
]

{ #category : #running }
WinProcessManagerTest >> testWriteProcessMemory [

	| address writeValue sizeToWrite return |
	sizeToWrite := 4.
	address := FFIBackend current allocate: sizeToWrite.
	writeValue := FFIBackend current allocate: sizeToWrite.
	address uint32AtOffset: 0 put: 0.
	writeValue uint32AtOffset: 0 put: 42.
	return := processManager
		          writeProcessMemory: vmProcess
		          address: address
		          buffer: writeValue
		          size: sizeToWrite
		          nbBytesWritten: nil.

	self deny: return equals: false.
	self assert: (address uint32AtOffset: 0) equals: 42.
	address free.
	writeValue free
]
