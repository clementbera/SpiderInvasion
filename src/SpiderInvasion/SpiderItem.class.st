"
Je suis un element affiche dans la spirder arena.

arena <SpiderArena>
pos <Point> position dans la spider arena.
"
Class {
	#name : #SpiderItem,
	#superclass : #Object,
	#instVars : [
		'arena',
		'pos'
	],
	#category : #SpiderInvasion
}

{ #category : #'instance creation' }
SpiderItem class >> arena: arena pos: pos [
	^ self new
		arena: arena;
		pos: pos;
		yourself
]

{ #category : #testing }
SpiderItem class >> drawable [
	^ false
]

{ #category : #'instance creation' }
SpiderItem class >> resourceID [
	self subclassResponsibility 
]

{ #category : #accessing }
SpiderItem >> arena [
	^ arena
]

{ #category : #accessing }
SpiderItem >> arena: anObject [
	arena := anObject
]

{ #category : #rendering }
SpiderItem >> die [
	arena 
		setSpritePosition: (SpiderExplode arena: arena pos: pos tick: 6)
		to: pos
]

{ #category : #testing }
SpiderItem >> isEmpty [
	^ false
		
]

{ #category : #movement }
SpiderItem >> missileEnter: missile [
	self die.
	arena removeMissile: missile.
]

{ #category : #accessing }
SpiderItem >> pos [
	^ pos
]

{ #category : #accessing }
SpiderItem >> pos: anObject [
	pos := anObject
]

{ #category : #rendering }
SpiderItem >> renderOn: canvas [
	| translation |
	"Les sprites sont de taille 48x48."
	translation := pos - (1@1) * arena spriteSize.
	canvas pathTransform translateBy: translation. 
	canvas setPaint: (arena paintFor: self class resourceID).
	canvas draw.
	canvas pathTransform translateBy: 0@0 - translation. 
]

{ #category : #movement }
SpiderItem >> spiderEnter: spider [
	| leftOrRight newSpiderPos |
	leftOrRight := #(-1 1) atRandom.
	newSpiderPos := spider pos + (leftOrRight @ 0).
	((arena isValidePosition: newSpiderPos) and: [ (arena itemAt: newSpiderPos) isEmpty ])
		ifTrue: [ arena setSpritePosition: spider to: newSpiderPos ]
]

{ #category : #accessing }
SpiderItem >> x [
	^ pos x
]

{ #category : #accessing }
SpiderItem >> y [
	^ pos y
]
