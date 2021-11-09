Class {
	#name : #Pragma42,
	#superclass : #ActivePragma,
	#category : #'ActivePragma-Tests'
}

{ #category : #events }
Pragma42 >> onCompilation: aCompilationContext [
	"here just add the plugin"
	aCompilationContext addASTTransformationPlugin: ASTPluginMeaningOfLife
]

{ #category : #events }
Pragma42 >> onInstallation: aClass [
	"set property on the class, all methods in that class now use this plugin"
	aClass propertyAt: #CompilerPlugin put: ASTPluginMeaningOfLife
]

{ #category : #events }
Pragma42 >> onRemoval:aClass [ 
	
	aClass removeProperty: #CompilerPlugin
]
