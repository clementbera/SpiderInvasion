"
Je suis un element anime dans la spider arena.

tick <SmallInteger> nombre de cycles de rendu graphique avant la prochaine etape d'animation.
currentTick <SmallInteger> Je suis initialise a la valeur de tick et je suis decremente a chaque cycle de rendu graphique jusqu'a 0, ou je declenche l'etape suivante de l'animation.
"
Class {
	#name : #SpiderAnimatedItem,
	#superclass : #SpiderItem,
	#instVars : [
		'tick',
		'currentTick'
	],
	#category : #SpiderInvasion
}

{ #category : #'instance creation' }
SpiderAnimatedItem class >> arena: arena pos: pos tick: numTick [
	^ (self arena: arena pos: pos)
		tick: numTick;
		yourself
]

{ #category : #testing }
SpiderAnimatedItem class >> drawable [
	^ false
]

{ #category : #accessing }
SpiderAnimatedItem >> action [
	self subclassResponsibility 
]

{ #category : #rendering }
SpiderAnimatedItem >> doTick [
	currentTick := currentTick - 1.
	currentTick = 0 ifTrue: [ self action. currentTick := tick ].
]

{ #category : #rendering }
SpiderAnimatedItem >> renderOn: canvas [
	self doTick.
	super renderOn: canvas.
]

{ #category : #accessing }
SpiderAnimatedItem >> tick [
	^ tick
]

{ #category : #accessing }
SpiderAnimatedItem >> tick: anObject [
	currentTick := tick := anObject.
	
]
