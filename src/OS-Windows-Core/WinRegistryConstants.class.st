"
Includes constants as defined in winreg.h
"
Class {
	#name : #WinRegistryConstants,
	#superclass : #SharedPool,
	#classVars : [
		'HKEY',
		'HKEY_CLASSES_ROOT',
		'HKEY_CURRENT_CONFIG',
		'HKEY_CURRENT_USER',
		'HKEY_DYN_DATA',
		'HKEY_LOCAL_MACHINE',
		'HKEY_PERFORMANCE_DATA',
		'HKEY_USERS',
		'KEY_ALL_ACCESS',
		'KEY_CREATE_LINK',
		'KEY_CREATE_SUB_KEY',
		'KEY_ENUMERATE_SUB_KEYS',
		'KEY_EXECUTE',
		'KEY_NOTIFY',
		'KEY_QUERY_VALUE',
		'KEY_READ',
		'KEY_SET_VALUE',
		'KEY_WOW64_32KEY',
		'KEY_WOW64_64KEY',
		'KEY_WRITE',
		'PHKEY',
		'REG_BINARY',
		'REG_CREATED_NEW_KEY',
		'REG_DWORD',
		'REG_DWORD_BIG_ENDIAN',
		'REG_DWORD_LITTLE_ENDIAN',
		'REG_EXPAND_SZ',
		'REG_FULL_RESOURCE_DESCRIPTOR',
		'REG_LINK',
		'REG_MULTI_SZ',
		'REG_NONE',
		'REG_NOTIFY_CHANGE_ATTRIBUTES',
		'REG_NOTIFY_CHANGE_LAST_SET',
		'REG_NOTIFY_CHANGE_NAME',
		'REG_NOTIFY_CHANGE_SECURITY',
		'REG_OPENED_EXISTING_KEY',
		'REG_OPTION_NON_VOLATILE',
		'REG_OPTION_VOLATILE',
		'REG_QWORD',
		'REG_QWORD_LITTLE_ENDIAN',
		'REG_RESOURCE_LIST',
		'REG_RESOURCE_REQUIREMENTS_LIST',
		'REG_SZ'
	],
	#category : #'OS-Windows-Core-Support'
}

{ #category : #'private - initialization' }
WinRegistryConstants class >> initRegistryConstants [

	HKEY_CLASSES_ROOT := 16r80000000.
	HKEY_CURRENT_USER := 16r80000001 .
	HKEY_LOCAL_MACHINE := 16r80000002.
	HKEY_USERS := 16r80000003.
	
	HKEY_PERFORMANCE_DATA := 16r80000004.
	HKEY_CURRENT_CONFIG := 16r80000005.
	HKEY_DYN_DATA := 16r80000006.
	
	REG_OPTION_VOLATILE := 1.
	REG_OPTION_NON_VOLATILE := 0.
	
	REG_CREATED_NEW_KEY := 1.
	REG_OPENED_EXISTING_KEY := 2.
	
	REG_NONE := 0.
	REG_SZ := 1.
	REG_EXPAND_SZ := 2.
	REG_BINARY := 3.
	REG_DWORD_LITTLE_ENDIAN := 4.
	REG_DWORD := 4.
	REG_DWORD_BIG_ENDIAN := 5.
	REG_LINK := 6.
	REG_MULTI_SZ := 7.
	REG_RESOURCE_LIST := 8.
	REG_FULL_RESOURCE_DESCRIPTOR := 9.
	REG_RESOURCE_REQUIREMENTS_LIST := 10.
	REG_QWORD_LITTLE_ENDIAN := 11.
	REG_QWORD := 11.
	REG_NOTIFY_CHANGE_NAME := 1.
	REG_NOTIFY_CHANGE_ATTRIBUTES := 2.
	REG_NOTIFY_CHANGE_LAST_SET := 4.
	REG_NOTIFY_CHANGE_SECURITY := 8.

	KEY_ALL_ACCESS := 16rF003F.
	KEY_CREATE_LINK := 16r0020.
	KEY_CREATE_SUB_KEY := 16r0004.
	KEY_ENUMERATE_SUB_KEYS := 16r0008.
	KEY_EXECUTE := 16r20019.
	KEY_NOTIFY := 16r0010.
	KEY_QUERY_VALUE := 16r0001.
	KEY_READ := 16r20019.
	KEY_SET_VALUE := 16r0002.
	KEY_WOW64_32KEY := 16r0200.
	KEY_WOW64_64KEY := 16r0100.
	KEY_WRITE := 16r20006.
	
]

{ #category : #'private - initialization' }
WinRegistryConstants class >> initRegistryTypes [

	HKEY := #WinRegistryKey.
	PHKEY := 'HKEY*'.
]

{ #category : #'class initialization' }
WinRegistryConstants class >> initialize [ 
	"Initializes the receiver class
	
		self initialize
	"
	
	self 
		initRegistryConstants;
		initRegistryTypes
]