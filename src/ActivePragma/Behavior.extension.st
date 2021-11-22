Extension { #name : #Behavior }

{ #category : #'*ActivePragma' }
Behavior >> compiler [

	"Answer a compiler appropriate for source methods of this class."

	| compiler |
	compiler := self compilerClass new
		            environment: self environment;
		            class: self.

	(self hasInheritedPropertyWithPrefix: #CompilerPlugin) ifTrue: [
		(self inheritedPropertiesWithPrefix: #CompilerPlugin) valuesDo: 
		[:plugin | compiler addPlugin: plugin] ].
	^ compiler
]

{ #category : #'*ActivePragma' }
Behavior >> hasInheritedProperty: aKey [

	^ (self inheritedPropertyAt: aKey) isNotNil 
]

{ #category : #'*ActivePragma' }
Behavior >> hasInheritedPropertyWithPrefix: aKey [

	"Lazy implementation 

	^ (self inheritedPropertyWithPrefix: aKey) isNotNil"

	self properties ifNotNil: [ 
		(self properties keys anySatisfy: [ :each | 
			 each includesSubstring: aKey at: 1 ]) ifTrue: [ ^ true ] ].
	self superclass
		ifNil: [ ^ false ]
		ifNotNil: [ ^ self superclass hasInheritedPropertyWithPrefix: aKey ]
]

{ #category : #'*ActivePragma' }
Behavior >> inheritedProperties [

	| allProperties |
	self superclass ifNil: [ ^ self properties ].
	allProperties := self superclass inheritedProperties copy.
	self properties ifNotNil: [ 
		allProperties := allProperties ifNil: [ 
			                 Dictionary new ].
		self properties keysAndValuesDo: [ :k :v | 
			allProperties at: k put: v ] ].

	^ allProperties
]

{ #category : #'*ActivePragma' }
Behavior >> inheritedPropertiesWithPrefix: aPrefix [

	self inheritedProperties ifNil: [ ^nil ].
	
	^ self inheritedProperties associationsSelect: [ :association | 
		association key includesSubstring: aPrefix at: 1 ].
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
