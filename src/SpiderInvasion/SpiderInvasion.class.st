"
Je represente le jeu.

resourceManager <ResourceManager>
window  <Handle> reference vers la fenetre SDL2 de la librairie exterieure a Pharo.
surface <CairoSurface> 
arena <SpiderArena>
renderingProcess <Process> process de rendu graphique, on garde une reference pour pouvoir le terminer lorsque le jeu se termine.
"
Class {
	#name : #SpiderInvasion,
	#superclass : #Object,
	#instVars : [
		'resourceManager',
		'window',
		'surface',
		'arena',
		'renderingProcess'
	],
	#category : #SpiderInvasion
}

{ #category : #'instance creation' }
SpiderInvasion class >> size: size [
	^ self new 	
		initializeWithSize: size;
		yourself
		
]

{ #category : #initialization }
SpiderInvasion >> draw [
	surface drawDuring: [ :canvas | 
		canvas setPaint: Color black.
		canvas drawShape: (0@0 corner: window extent).
		arena renderOn: canvas ].
	self refreshScreen.
]

{ #category : #initialization }
SpiderInvasion >> drawAt50FPS [ 
	[ true ] whileTrue: [	
		| time drawTime |
		time := DateAndTime now.
		self draw.
		drawTime := DateAndTime now - time.
		drawTime < 20 milliSeconds 
			ifTrue: [ (20 milliSeconds - drawTime) wait ] ]
	
]

{ #category : #initialization }
SpiderInvasion >> initializeWithSize: size [
	resourceManager := ResourceManager new.
	self setUpSDL2Window: size.
	self setUpCairoSurface.
	self setUpArena: size.
	renderingProcess := [ self drawAt50FPS ] fork.
	
]

{ #category : #events }
SpiderInvasion >> leftKeyPressed [
	arena spaceShip left
]

{ #category : #initialization }
SpiderInvasion >> refreshScreen [
	window handle handle updateWindowSurface
]

{ #category : #events }
SpiderInvasion >> rightKeyPressed [
	arena spaceShip right
]

{ #category : #initialization }
SpiderInvasion >> setUpArena: size [
	arena := SpiderArena size: size.
	arena resourceManager: resourceManager.
	arena initializePaintsWithSurface: surface. 
]

{ #category : #initialization }
SpiderInvasion >> setUpCairoSurface [
	surface := AthensCairoSDLSurface fromSDLSurface: window handle handle getWindowSurface.
]

{ #category : #initialization }
SpiderInvasion >> setUpSDL2Window: size [
	window := OSWindow createWithAttributes: (OSWindowAttributes new 
		title: 'Spider Invasion';
		resizable: false;
		extent: size * resourceManager spriteSize;
		yourself).
	window eventHandler: (SpiderEventHandler new 
		game: self;
		yourself)
]

{ #category : #events }
SpiderInvasion >> spaceKeyPressed [
	arena spaceShip fire
]

{ #category : #initialization }
SpiderInvasion >> terminateRenderingProcess [
	renderingProcess ifNotNil: [:it | it terminate]
]
