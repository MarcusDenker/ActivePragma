Class {
	#name : #MethodReferenceTest,
	#superclass : #TestCase,
	#category : #'ActivePragma-Tests'
}

{ #category : #tests }
MethodReferenceTest >> testCreationViaMethod [
	| ref |
	ref := (Object>>#halt) asMethodReference.
	self assert: ref getClass equals: Object>>#halt.
]

{ #category : #tests }
MethodReferenceTest >> testGetClass [
	| ref |
	ref := MethodReference method: Object>>#halt.
	self assert: ref getClass equals: Object>>#halt.
]
