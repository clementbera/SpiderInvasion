"
Je gere les evenements clavier qui proviennent de SDL2.  Je dispatch les evenements sur l'objet game en variable d'instance. Les dispatchs ne sont pas fait directement sur le vaisseau pour pouvoir ajouter d'autres fonctionnalites (Pause, etc.).

game <SpiderInvasion> 
LeftKey RightKey SpaceKey <SmallInteger>  codes de touches clavier utilises pour detecter quelle touche clavier a ete pressee.
"
Class {
	#name : #SpiderEventHandler,
	#superclass : #OSWindowEventVisitor,
	#instVars : [
		'game'
	],
	#classVars : [
		'LeftKey',
		'RightKey',
		'SpaceKey'
	],
	#category : #SpiderInvasion
}

{ #category : #initialization }
SpiderEventHandler class >> initialize [
	LeftKey := 80. 
	RightKey := 79. 
	SpaceKey := 44.
]

{ #category : #accessing }
SpiderEventHandler >> game [
	^ game
]

{ #category : #accessing }
SpiderEventHandler >> game: anObject [
	game := anObject
]

{ #category : #visiting }
SpiderEventHandler >> visitKeyUpEvent: event [
	event scanCode caseOf: { 
		[ LeftKey ] -> [ game leftKeyPressed ].
		[ RightKey ] -> [ game rightKeyPressed ].
		[ SpaceKey ] -> [ game spaceKeyPressed ]
	 } otherwise: [  ]
]

{ #category : #visiting }
SpiderEventHandler >> visitWindowCloseEvent: event [
	game terminateRenderingProcess.
	Smalltalk snapshot: false andQuit: true.
]
