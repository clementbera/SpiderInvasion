"
Je represente le vaisseau qui tire.

minX <SmallInteger> position x minimale (a gauche de l'ecran)
maxX <SmallInteger> position x maximale (a droite de l'ecran)
loaded <Boolean> autorise le vaisseau a tirer. Mis a false lors d'un tir, remis a true lorsque le missile detruit quelque chose ou sort de l'ecran.

"
Class {
	#name : #SpiderSpaceShip,
	#superclass : #SpiderItem,
	#instVars : [
		'loaded'
	],
	#category : #SpiderInvasion
}

{ #category : #testing }
SpiderSpaceShip class >> drawable [
	^ true
]

{ #category : #constants }
SpiderSpaceShip class >> resourceID [
	^ #spaceShip
]

{ #category : #game }
SpiderSpaceShip >> fire [
	| missilePos |
	loaded ifTrue: [
		loaded := false.
		missilePos := pos - (0@1).
		arena 
			missile: (SpiderMissile arena: arena pos: missilePos tick: 5) 
			enter: missilePos.].
	
		
]

{ #category : #initialization }
SpiderSpaceShip >> initialize [

	super initialize.

	loaded := true
]

{ #category : #game }
SpiderSpaceShip >> left [
	| newPos |
	self x > arena minX ifTrue: [ 
		newPos := pos - (1@0).
		(arena itemAt: newPos) isEmpty
			ifTrue: [	arena setSpritePosition: self to: newPos ] ]
	
]

{ #category : #game }
SpiderSpaceShip >> reload [
	loaded := true.
]

{ #category : #game }
SpiderSpaceShip >> right [
	| newPos |
	self x < arena maxX ifTrue: [ 
		newPos := pos + (1@0).
		(arena itemAt: newPos) isEmpty
			ifTrue: [ arena setSpritePosition: self to: newPos ] ]
	
]
