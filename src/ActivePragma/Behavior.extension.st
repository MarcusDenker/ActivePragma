Extension { #name : #Behavior }

{ #category : #'*ActivePragma' }
Behavior >> compiler [
	"Answer a compiler appropriate for source methods of this class."
	| compiler |
	compiler := self compilerClass new
		environment: self environment;
		class: self. 
	
	(self hasProperty: #CompilerPlugin) ifTrue: [ compiler addPlugin:( self propertyAt: #CompilerPlugin) ].
	^compiler
	
]
