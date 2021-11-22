Class {
	#name : #Pragma42,
	#superclass : #ActivePragma,
	#category : #'ActivePragma-Tests'
}

{ #category : #accessing }
Pragma42 class >> selector [

	^ #TestPragma42
]

{ #category : #events }
Pragma42 >> onCompilation: aCompilationContext [
	"here just add the plugin"
	aCompilationContext addASTTransformationPlugin: ASTPluginMeaningOfLife.
]

{ #category : #events }
Pragma42 >> onFirstInstallationInClass: aClass [
	"set property on the class, all methods in that class now use this plugin"
	aClass propertyAt: #CompilerPlugin42 put: ASTPluginMeaningOfLife.
]

{ #category : #events }
Pragma42 >> onInstallation: aClass [
	"set property on the class, all methods in that class now use this plugin"
	|propertyValue|
	propertyValue := aClass propertyAt: #ClassInstallationCounter.
	propertyValue 
		ifNil: [ aClass propertyAt: #ClassInstallationCounter put: 1 ] 
		ifNotNil: [ aClass removeProperty: #ClassInstallationCounter.
			aClass propertyAt: #ClassInstallationCounter put: (propertyValue + 1) ].
	
]

{ #category : #events }
Pragma42 >> onLastRemovalFromClass:aClass [ 
	aClass removeProperty: #CompilerPlugin42.
	aClass removeProperty: #ClassInstallationCounter
]

{ #category : #events }
Pragma42 >> onRemoval: aClass [

	|propertyValue|
	propertyValue := aClass propertyAt: #ClassInstallationCounter.
	aClass removeProperty: #ClassInstallationCounter.
	aClass propertyAt: #ClassInstallationCounter put: (propertyValue - 1).
	
]
