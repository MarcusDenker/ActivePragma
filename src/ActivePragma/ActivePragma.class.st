"
ActivePragmas are subclasses that override 

- onInstallation:
- onRemoval: 
- onCompilation
"
Class {
	#name : #ActivePragma,
	#superclass : #Pragma,
	#classInstVars : [
		'allMethods'
	],
	#category : #'ActivePragma-Core'
}

{ #category : #initialization }
ActivePragma class >> initialize [
	SystemAnnouncer uniqueInstance weak when: MethodModified send: #methodChanged: to: self.
	SystemAnnouncer uniqueInstance weak when: MethodRemoved send: #methodRemoved: to: self.
	SystemAnnouncer uniqueInstance weak when: MethodAdded send: #methodAdded: to: self.
	allMethods := Set new.
]

{ #category : #triggering }
ActivePragma class >> methodAdded: aMethodAdded [ 
	aMethodAdded method pragmas 
		select:  [ :each | each selector == self selector ]
		thenDo: [ :each | 
			each onInstallation: aMethodAdded classAffected.
			allMethods add: aMethodAdded method].
	
]

{ #category : #triggering }
ActivePragma class >> methodChanged: aMethodChanged [ 
	allMethods remove: aMethodChanged oldMethod ifAbsent: [ ].
	aMethodChanged method pragmas 
		select:  [ :each | each selector == self selector ]
		thenDo: [ :each | 
			each onInstallation: aMethodChanged classAffected.
			allMethods add: aMethodChanged method].
	
]

{ #category : #triggering }
ActivePragma class >> methodRemoved: aMethodRemoved [
	"here we need to remove it from all installed methods tracked here, last removal means
	removing the compiler pluging"
	allMethods remove: aMethodRemoved method ifAbsent: [ ].
	allMethods ifEmpty: [ 
		aMethodRemoved method pragmas 
			select:  [ :each | each selector == self selector ]
			thenDo: [ :each |each onRemoval: aMethodRemoved classAffected ]]
]

{ #category : #accessing }
ActivePragma class >> selector [
	^#myPragma
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
ActivePragma >> onInstallation: aClass [
	"this method is called whenever a method using the active pragma is installed in a class"
]

{ #category : #events }
ActivePragma >> onRemoval: aClass [
	"this method is called whenever the last method using the active pragma is removed from a class"
]
