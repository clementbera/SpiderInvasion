"
Je represente une case vide de l'arene.
"
Class {
	#name : #SpiderEmpty,
	#superclass : #SpiderItem,
	#category : #SpiderInvasion
}

{ #category : #testing }
SpiderEmpty class >> drawable [
	^ false
]

{ #category : #testing }
SpiderEmpty >> isEmpty [
	^ true
]

{ #category : #movement }
SpiderEmpty >> missileEnter: missile [
	 arena setSpritePosition: missile to: pos
]

{ #category : #rendering }
SpiderEmpty >> renderOn: canvas [
	
]

{ #category : #movement }
SpiderEmpty >> spiderEnter: spider [
	 arena setSpritePosition: spider to: pos
]
