"
ActivePragmas are subclasses that override 

- onInstallation:
- onRemoval: 
- onCompilation
"
Class {
	#name : #ActivePragma,
	#superclass : #Pragma,
	#classVars : [
		'MethodsCache'
	],
	#category : #'ActivePragma-Core'
}

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
			(MethodsCache at: each selector ifAbsentPut: [ Set new ]) 
				ifEmpty: [ each onFirstInstallationInClass: aMethodAdded classAffected ].
			each onInstallation: aMethodAdded classAffected.
			(MethodsCache at: each selector) add: aMethodAdded method asMethodReference]
]

{ #category : #triggering }
ActivePragma class >> methodChanged: aMethodChanged [ 
	| newPragmas removedPragmas |

	newPragmas := aMethodChanged method pragmas difference:  aMethodChanged oldMethod pragmas. 
	removedPragmas := aMethodChanged oldMethod pragmas difference: aMethodChanged method pragmas.
	
	"copy from methodAdded, to be refactored."
	newPragmas select: [ :each | each isActivePragma ]
		thenDo: [ :each |
			(MethodsCache at: each selector ifAbsentPut: [ Set new ]) 
				ifEmpty: [ each onFirstInstallationInClass: aMethodChanged classAffected ].
			each onInstallation: aMethodChanged classAffected.
			(MethodsCache at: each selector) add: aMethodChanged method asMethodReference].
		
	"copy from methodRemoved, to be refactored."	
	removedPragmas select: [ :each | each isActivePragma ]
		thenDo: [ :each | 
			(MethodsCache at: each selector) remove: aMethodChanged method asMethodReference.
			each onRemoval: aMethodChanged classAffected.
			(MethodsCache at: each selector) ifEmpty: [ 
				each onLastRemovalFromClass: aMethodChanged classAffected ] ]
	
]

{ #category : #triggering }
ActivePragma class >> methodRemoved: aMethodRemoved [
	
	aMethodRemoved method pragmas
		select: [ :each | each isActivePragma ]
		thenDo: [ :each | 
			(MethodsCache at: each selector) remove: aMethodRemoved method asMethodReference.
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
ActivePragma >> onCompilation: aCompilationContext [
	"this hook is called by the semantic analysis phase of compilation"
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
