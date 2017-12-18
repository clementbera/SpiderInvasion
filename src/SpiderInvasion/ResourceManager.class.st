"
Je suis responsable du chargment des ressources graphiques sous forme de PNG.

La methode resourceNames specifie les ressources a charger (identifiant de la ressource et chemin du fichier .png).
"
Class {
	#name : #ResourceManager,
	#superclass : #Object,
	#instVars : [
		'resources'
	],
	#category : #SpiderInvasion
}

{ #category : #'ressource access' }
ResourceManager >> get: resourceName [
	^ resources at: resourceName
]

{ #category : #initialization }
ResourceManager >> initialize [
	super initialize.
	resources := Dictionary new.
	self loadResources.
]

{ #category : #loading }
ResourceManager >> loadResources [
	self resourceNames keysAndValuesDo: [ :name :fileName |
		resources at: name put: (PNGReadWriter formFromFileNamed: fileName) ]
]

{ #category : #constants }
ResourceManager >> resourceNames [
	^ { #spider -> 'resources/spider.png'.
		 #wall -> 'resources/wall.png'.
		 #missile -> 'resources/missile.png'.
		 #explode -> 'resources/explode.png'.
		 #spaceShip -> 'resources/spaceShip.png' } asDictionary
]

{ #category : #constants }
ResourceManager >> spriteSize [
	^ 48@48
]
