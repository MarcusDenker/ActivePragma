Class {
	#name : 'MethodReference',
	#superclass : 'Object',
	#instVars : [
		'selector',
		'nameOfClass'
	],
	#category : 'ActivePragma-Tests',
	#package : 'ActivePragma',
	#tag : 'Tests'
}

{ #category : 'accessing' }
MethodReference class >> method: aCompiledMethod [

	^ self new
		  selector: aCompiledMethod selector;
		  nameOfClass: aCompiledMethod methodClass name;
		  yourself
]

{ #category : 'comparing' }
MethodReference >> = anObject [
	^ anObject class == self class
		and: [ anObject selector = selector
				and: [ anObject nameOfClass = nameOfClass ]] 
]

{ #category : 'accessing' }
MethodReference >> getClass [
	^ (self class environment at: nameOfClass) >> selector
]

{ #category : 'comparing' }
MethodReference >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ nameOfClass hash bitXor: selector hash
]

{ #category : 'accessing' }
MethodReference >> nameOfClass [

	^ nameOfClass
]

{ #category : 'accessing' }
MethodReference >> nameOfClass: anObject [

	nameOfClass := anObject
]

{ #category : 'accessing' }
MethodReference >> selector [

	^ selector
]

{ #category : 'accessing' }
MethodReference >> selector: anObject [

	selector := anObject
]
