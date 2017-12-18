"
Je represente un mur dans l'arene.
"
Class {
	#name : #SpiderWall,
	#superclass : #SpiderItem,
	#category : #SpiderInvasion
}

{ #category : #testing }
SpiderWall class >> drawable [
	^ true
]

{ #category : #'instance creation' }
SpiderWall class >> resourceID [
	^ #wall
]
