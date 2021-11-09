Extension { #name : #OCASTTranslator }

{ #category : #'*ActivePragma' }
OCASTTranslator >> visitPragmaNode: aPragmaNode [

	| var pragma |
	pragma := aPragmaNode asPragma.
	pragma isActivePragma ifTrue: [ pragma onCompilation: aPragmaNode methodNode compilationContext].
	methodBuilder addPragma: pragma.
	
	
	"if the pragma is a primitive that defines an error variable, we need to store error value 
	which is on the stack"
	aPragmaNode isPrimitiveError ifFalse: [ ^ self ].
	var := aPragmaNode methodNode scope lookupVar: aPragmaNode primitiveErrorVariableName.
	var emitStore: methodBuilder.
]
