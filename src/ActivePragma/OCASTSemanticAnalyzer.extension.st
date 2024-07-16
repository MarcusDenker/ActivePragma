Extension { #name : 'OCASTSemanticAnalyzer' }

{ #category : '*ActivePragma' }
OCASTSemanticAnalyzer >> visitPragmaNode: aPragmaNode [

	| varNode pragma|
	super visitPragmaNode: aPragmaNode.
	pragma := aPragmaNode asPragma.
	aPragmaNode pragma: pragma.
	pragma isActivePragma ifTrue: [ pragma onCompilation: aPragmaNode methodNode compilationContext].
	aPragmaNode selector = #compilerOptions: ifTrue: [
		aPragmaNode pragma sendTo:
			self compilationContext ].

	"if the pragma is a primitive that defines an error variable, we need to declare a temp
	for it"
	aPragmaNode isPrimitiveError ifFalse: [ ^ self ].
	varNode := RBVariableNode named: aPragmaNode primitiveErrorVariableName.
	self declareVariableNode: varNode as: (PrimitiveErrorVariable node: varNode)
]
