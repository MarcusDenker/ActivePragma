Class {
	#name : #ActivePragmaTest,
	#superclass : #TestCase,
	#category : #'ActivePragma-Tests'
}

{ #category : #running }
ActivePragmaTest >> setUp [

	Pragma42 subscribeToEvents.
	^ super setUp
]

{ #category : #running }
ActivePragmaTest >> tearDown [ 
	super tearDown.
	MyClass methodDictionary do: [ :each | MyClass removeSelector: each selector ].
	MyClass properties ifNotNil: [MyClass properties removeAll].
	(ActivePragma classVarNamed: #MethodsCache) at: Pragma42 selector ifPresent: [ : pr | pr removeAll].
	"Put here a common initialization logic for tests"
	Pragma42 unsubscribeToEvents.
]

{ #category : #tests }
ActivePragmaTest >> testOnFirstInstallation [

|compiledMethod|

	self deny: (MyClass hasProperty: #CompilerPlugin42).

	MyClass compile:'testingPragma42
		<TestPragma42>		
		^42.'.
	compiledMethod := MyClass>>#testingPragma42.
	self assert: (MyClass hasProperty: #CompilerPlugin42).
	self assert: compiledMethod literals first equals: 'meaning of life'.
	
"Check that the property is only added on the first addition of the pragma"
	MyClass removeProperty: #CompilerPlugin42.
	compiledMethod := MyClass compile:'testingPragma42bis
		<TestPragma42>'.
	self deny: (MyClass hasProperty: #CompilerPlugin42).
		
	MyClass removeSelector: #testingPragma42.
	MyClass removeSelector: #testingPragma42bis
]

{ #category : #tests }
ActivePragmaTest >> testOnInstallation [

|compiledMethod|

	self deny: (MyClass hasProperty: #ClassInstallationCounter).

	compiledMethod := MyClass compile:'testingPragma42
		<TestPragma42>'.
	self assert: (MyClass propertyAt: #ClassInstallationCounter) equals: 1.

"Check that the property is only added on the first addition of the pragma"
	MyClass propertyAt: #ClassInstallationCounter .
	compiledMethod := MyClass compile:'testingPragma42bis
		<TestPragma42>'.
	self assert: (MyClass propertyAt: #ClassInstallationCounter) equals: 2.
	
	self assert: ((ActivePragma classVarNamed: #MethodsCache) at: #TestPragma42) size equals: 2.
		
	MyClass removeSelector: #testingPragma42.
	MyClass removeSelector: #testingPragma42bis
]

{ #category : #tests }
ActivePragmaTest >> testOnLastRemovalFromClass [

|compiledMethod|

	self deny: (MyClass hasProperty: #CompilerPlugin42).

	compiledMethod := MyClass compile:'testingPragma42
		<TestPragma42>'.
	self assert: (MyClass hasProperty: #CompilerPlugin42).

	MyClass removeSelector: #testingPragma42.
	self deny: (MyClass hasProperty: #CompilerPlugin42)
	
]

{ #category : #tests }
ActivePragmaTest >> testOnParse [

	|compiledMethod|

	compiledMethod := MyClass compiler compile:'testingPragma42
		<TestPragma42>
		^42'.
	"as the method is not installed as has no source pointer, it decompiles on #sourceCode"
	self assert: (compiledMethod sourceCode includesSubstring: 'meaning of life').
]

{ #category : #tests }
ActivePragmaTest >> testOnRemoval [

|compiledMethod|

	self deny: (MyClass hasProperty: #ClassInstallationCounter).

	compiledMethod := MyClass compile:'testingPragma42
		<TestPragma42>'.
	self assert: (MyClass propertyAt: #ClassInstallationCounter) equals: 1.

"Check that the property is only added on the first addition of the pragma"
	MyClass propertyAt: #ClassInstallationCounter .
	compiledMethod := MyClass compile:'testingPragma42bis
		<TestPragma42>'.
	self assert: (MyClass propertyAt: #ClassInstallationCounter) equals: 2.
		
	MyClass removeSelector: #testingPragma42.
	self assert: (MyClass propertyAt: #ClassInstallationCounter) equals: 1.
	
	MyClass removeSelector: #testingPragma42bis
]
