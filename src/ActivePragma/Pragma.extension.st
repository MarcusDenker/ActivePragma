Extension { #name : #Pragma }

{ #category : #'*ActivePragma' }
Pragma >> isActivePragma [
	^false
]

{ #category : #'*ActivePragma' }
Pragma class >> selector: aSymbol arguments: anArray [
	| class | 
	class := self allSubclasses detect: [ :pragmaClass | pragmaClass selector = aSymbol ] ifNone: [ self ].
	^ class new
		selector: aSymbol;
		arguments: anArray;
		yourself
]
