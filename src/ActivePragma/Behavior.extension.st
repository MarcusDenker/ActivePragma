Extension { #name : #Behavior }

{ #category : #'*ActivePragma' }
Behavior >> compiler [

	"Answer a compiler appropriate for source methods of this class."

	| compiler |
	compiler := self compilerClass new
		            environment: self environment;
		            class: self.

	(self hasInheritedProperty: #CompilerPlugin) ifTrue: [ 
		compiler addPlugin: (self propertyAt: #CompilerPlugin) ].
	^ compiler
]

{ #category : #'*ActivePragma' }
Behavior >> hasInheritedProperty: aKey [

	^ (self inheritedPropertyAt: aKey) isNotNil 
]

{ #category : #'*ActivePragma' }
Behavior >> hasInheritedPropertyWithPrefix: aKey [
"Could be more efficient if we start looking from the class for any property that start with the prefix and return true as soon as we find one"

	^ (self inheritedPropertyWithPrefix: aKey) isNotEmpty
]

{ #category : #'*ActivePragma' }
Behavior >> inheritedProperties [
|allProperties|
	
	self superclass ifNil: [ ^self properties ifNil: [^ Dictionary new]].
	allProperties := self superclass inheritedProperties copy.
	self properties ifNotNil:  [ self properties  keysAndValuesDo: [:k :v | allProperties at: k put: v].].

	^ allProperties 
]

{ #category : #'*ActivePragma' }
Behavior >> inheritedPropertyAt: aKey [

	^ self propertyAt: aKey ifAbsent: [ 
		  self superclass
			  ifNil: [ nil ]
			  ifNotNil: [ self superclass inheritedPropertyAt: aKey ] ]
]

{ #category : #'*ActivePragma' }
Behavior >> inheritedPropertyAt: propName ifAbsent: aBlock [

	| inheritedProperty |

	inheritedProperty := self inheritedPropertyAt: propName.

	^ inheritedProperty
		  ifNotNil: [ ^ inheritedProperty ]
		  ifNil: [ ^ aBlock value ]
]

{ #category : #'*ActivePragma' }
Behavior >> inheritedPropertyWithPrefix: aPrefix [

	^ self inheritedProperties associationsSelect: [ :association | 
		association key includesSubstring: aPrefix at: 1 ].
]
