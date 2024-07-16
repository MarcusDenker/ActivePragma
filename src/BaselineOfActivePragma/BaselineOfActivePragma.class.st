Class {
	#name : #BaselineOfActivePragma,
	#superclass : #BaselineOf,
	#category : #BaselineOfActivePragma
}

{ #category : #baselines }
BaselineOfActivePragma >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'ActivePragma' ].
	spec
			package: 'ActivePragmaLoading';
			package: 'ActivePragma'
			with: [ spec requires: #( 'ProtectedPharoLoading' ) ]
]
