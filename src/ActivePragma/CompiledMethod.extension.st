Extension { #name : #CompiledMethod }

{ #category : #'*ActivePragma' }
CompiledMethod >> asMethodReference [
	^ MethodReference method: self.
]
