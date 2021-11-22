"
ActivePragmas are subclasses that override 

- onInstallation:
- onRemoval: 
- onCompilation
"
Class {
	#name : #ActivePragma,
	#superclass : #Pragma,
	#category : #'ActivePragma-Core'
}

{ #category : #accessing }
ActivePragma class >> MethodsCache [
	^ MethodsCache

]

{ #category : #initialization }
ActivePragma class >> initialize [

	SystemAnnouncer uniqueInstance weak
		when: MethodModified
		send: #methodChanged:
		to: self.
	SystemAnnouncer uniqueInstance weak
		when: MethodRemoved
		send: #methodRemoved:
		to: self.
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded
		send: #methodAdded:
		to: self.
	MethodsCache := IdentityDictionary new
]

{ #category : #triggering }
ActivePragma class >> methodAdded: aMethodAdded [

	aMethodAdded method pragmas
		select: [ :each | each isActivePragma ]
		thenDo: [ :each |
			(MethodsCache at: each selector ifAbsentPut: [ IdentitySet new ]) 
				ifEmpty: [ each onFirstInstallationInClass: aMethodAdded classAffected ].
			each onInstallation: aMethodAdded classAffected.
			(MethodsCache at: each selector) add: aMethodAdded method ]
]

{ #category : #triggering }
ActivePragma class >> methodChanged: aMethodChanged [ 
	aMethodChanged oldMethod pragmas
		select: [:each | each isActivePragma ] 
		thenDo: [:each | (MethodsCache at: each selector) remove: aMethodChanged oldMethod ].
	aMethodChanged method pragmas 
		select:  [ :each | each isActivePragma ]
		thenDo: [ :each | 
			each onInstallation: aMethodChanged classAffected.
			(MethodsCache at: each selector ifAbsentPut: [ IdentitySet new ]) add: aMethodChanged method].
	
]

{ #category : #triggering }
ActivePragma class >> methodRemoved: aMethodRemoved [

	aMethodRemoved method pragmas
		select: [ :each | each isActivePragma ]
		thenDo: [ :each | 
			(MethodsCache at: each selector) remove: aMethodRemoved method.
			each onRemoval: aMethodRemoved classAffected.
			(MethodsCache at: each selector) ifEmpty: [ 
				each onLastRemovalFromClass: aMethodRemoved classAffected ] ]
]

{ #category : #accessing }
ActivePragma class >> selector [
	^ #ActivePragma

]

{ #category : #testing }
ActivePragma >> isActivePragma [
	^true
]

{ #category : #events }
ActivePragma >> onCompilation: aClass [
	"this method is called whenever a method using the active pragma is compiled"
]

{ #category : #events }
ActivePragma >> onFirstInstallationInClass: aClass [

	"this method is called whenever a method using the active pragma for the first time in a class is installed"

	
]

{ #category : #events }
ActivePragma >> onInstallation: aClass [
	"this method is called whenever a method using the active pragma is installed in a class"
]

{ #category : #events }
ActivePragma >> onLastRemovalFromClass: aClass [

	"this method is called whenever the last method using the active pragma is removed from a class"


]

{ #category : #events }
ActivePragma >> onRemoval: aClass [

	"this method is called whenever a method using the active pragma is removed from a class"

	
]
