Extension { #name : #BehaviorTest }

{ #category : #'*ActivePragma' }
BehaviorTest >> testHasInheritedProperty [
	| testValue |
	testValue := Date today.
	self classToBeTested superclass propertyAt: #testKeySelector put: testValue.
	self assert: (self classToBeTested hasInheritedProperty: #testKeySelector).
	
	"Cleanning up : "
	self classToBeTested superclass removeProperty: #testKeySelector.
	self deny: (self classToBeTested superclass hasProperty: #testKeySelector).
	self deny: (self classToBeTested hasInheritedProperty: #testKeySelector)
]

{ #category : #'*ActivePragma' }
BehaviorTest >> testHasInheritedPropertyWithPrefix [

	| testValue |
	testValue := Date today.
	self classToBeTested superclass
		propertyAt: #testKeySelector
		put: testValue.
	self assert:
		(self classToBeTested hasInheritedPropertyWithPrefix: #test).

	"Cleanning up : "
	self classToBeTested superclass removeProperty: #testKeySelector.
	self deny:
		(self classToBeTested superclass hasProperty: #testKeySelector).
	self deny:
		(self classToBeTested hasInheritedProperty: #testKeySelector)
]

{ #category : #'*ActivePragma' }
BehaviorTest >> testInheritedProperties [

	| testValue |

	testValue := Date today.
	self classToBeTested superclass
		propertyAt: #testKeySelector
		put: testValue.
	self classToBeTested superclass
		propertyAt: #testOverridenKeySelector
		put: 7.
	self classToBeTested propertyAt: #testSecondKeySelector put: 3.
	self classToBeTested propertyAt: #testOverridenKeySelector put: 1.

	self
		assert: self classToBeTested inheritedProperties
		equals: (Dictionary newFrom: { 
					 (#testKeySelector -> testValue).
					 (#testSecondKeySelector -> 3).
					 (#testOverridenKeySelector -> 1) }).

	"Cleanning up : "
	self classToBeTested superclass removeProperty: #testKeySelector.
	self classToBeTested superclass removeProperty:
		#testOverridenKeySelector.
	self classToBeTested removeProperty: #testSecondKeySelector.
	self classToBeTested removeProperty: #testOverridenKeySelector.
	self deny: (self classToBeTested hasInheritedPropertyWithPrefix: #test).
]

{ #category : #'*ActivePragma' }
BehaviorTest >> testInheritedPropertyAt [

	| testValue |
	testValue := Date today.
	self classToBeTested superclass
		propertyAt: #testKeySelector
		put: testValue.
	self assert: (self classToBeTested inheritedPropertyAt: #testKeySelector) equals: testValue.

	"Cleanning up : "
	self classToBeTested superclass removeProperty: #testKeySelector.
	self deny: (self classToBeTested superclass hasProperty: #testKeySelector).

]

{ #category : #'*ActivePragma' }
BehaviorTest >> testInheritedPropertyWithPrefix [

	| testValue |
	testValue := Date today.
	self classToBeTested superclass
		propertyAt: #testPrefixKeySelector
		put: testValue.
	self classToBeTested propertyAt: #testPrefixSecondKeySelector put: 3.
	self classToBeTested propertyAt: #testNotPrefixSelector put: 1.

	self
		assert:
		(self classToBeTested inheritedPropertiesWithPrefix: #testPrefix)
		equals: (Dictionary newFrom: { 
					 (#testPrefixKeySelector -> testValue).
					 (#testPrefixSecondKeySelector -> 3) }).

	"Cleanning up : "
	self classToBeTested superclass removeProperty:
		#testPrefixKeySelector.
	self classToBeTested removeProperty: #testPrefixSecondKeySelector.
	self classToBeTested removeProperty: #testNotPrefixSelector.

	self deny:
		(self classToBeTested hasInheritedPropertyWithPrefix: #test).
]
