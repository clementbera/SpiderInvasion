"
Je represente une explosion, i.e., la destruction d'un element comme une araignee ou un mur.
"
Class {
	#name : #SpiderExplode,
	#superclass : #SpiderAnimatedItem,
	#category : #SpiderInvasion
}

{ #category : #testing }
SpiderExplode class >> drawable [
	^ true
]

{ #category : #'instance creation' }
SpiderExplode class >> resourceID [
	^ #explode
]

{ #category : #rendering }
SpiderExplode >> action [
	arena removeSprite: self 
	
]
