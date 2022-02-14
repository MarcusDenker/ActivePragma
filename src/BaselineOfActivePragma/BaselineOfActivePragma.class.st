Class {
	#name : #BaselineOfActivePragma,
	#superclass : #BaselineOf,
	#category : #BaselineOfActivePragma
}

{ #category : #baseline }
BaselineOfActivePragma >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'ActivePragma' ]
]
