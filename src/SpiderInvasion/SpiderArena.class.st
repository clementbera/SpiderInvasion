"
Je represente le terrain de jeu. Le terrain est decoupe en un tableau a deux dimensions contenant des SpiderItem. 

A l'instantiation, on me donne sous la forme d'un point mes dimensions.

items <Array of Array of SpiderItems> Tableau a deux dimensions contenant les spider items.
paints <Dictionary (Symbol->CairoPaint)> Dictionaire contenant en clef les identifiants des resurces graphiques et en valeur les peintures presentes dans le cache de la surface Cairo.
spaceShip <SpiderSpaceShip> l'unique instance du vaisseau, accede directement pour la gestion des evenements claviers.
resourceManager <ResourceManager> 
 maxPos <Point> dimensions de l'arene.
"
Class {
	#name : #SpiderArena,
	#superclass : #Object,
	#instVars : [
		'items',
		'paints',
		'resourceManager',
		'maxPos',
		'spaceShip'
	],
	#category : #SpiderInvasion
}

{ #category : #'instance creation' }
SpiderArena class >> size: size [
	^ self new 
		initializeWithSize: size;
		yourself
]

{ #category : #debugging }
SpiderArena >> gtInspectorIrIn: composite [
	<gtInspectorPresentationOrder: 35> 
	composite text 
		title: 'Items';
		display: [ :anObject |
			String streamContents: [ :s | 
			anObject items do: [ :row |
				 row do: [ :elem | 
					s << (elem ifNil: ['O'] ifNotNil: [elem class name last uppercase asString]) << ' ' ].
				 s cr. ]. 
			]]
]

{ #category : #initialization }
SpiderArena >> initializeArena [
	items := (self minY to: self maxY) collect: [ :j | 
			(self minX to: self maxX) collect: [ :i | SpiderEmpty arena: self pos: i@j ] ]
]

{ #category : #initialization }
SpiderArena >> initializePaintsWithSurface: surface [
	paints := SmallDictionary new.
	SpiderItem withAllSubclassesDo: [ :itemClass | 
		itemClass drawable ifTrue: [
			paints 
				at: itemClass resourceID 
				put: (surface createFormPaint: (resourceManager get: itemClass resourceID)) ] ].
	
]

{ #category : #initialization }
SpiderArena >> initializeSpaceShip [
	| position |
	position := self randomX @ self maxY.
	spaceShip := SpiderSpaceShip arena: self pos: position.
	self setSpritePosition: spaceShip to: position
]

{ #category : #initialization }
SpiderArena >> initializeSpider [
	"Seulement moitie des cases de la premieres lignes contient une araignee au demarrage du jeu."
	1 to: self maxX // 2 do: [ :i |
		self newRandomSpiderTicked: self maxX + 10 + 20 atRandom ]
]

{ #category : #initialization }
SpiderArena >> initializeWalls [
	self withIndexItemsDo: [ :item :x :y |
		(y = self minY or: [y = self maxY]) ifFalse: [ 
			100 atRandom < 20 ifTrue: [ "20% de chances"
				self itemAt: x@y put: (SpiderWall arena: self pos: x@y) ] ] ]
]

{ #category : #initialization }
SpiderArena >> initializeWithSize: size [
	maxPos := size.
	self initializeArena.
	self initializeWalls.
	self initializeSpaceShip.
	self initializeSpider.
]

{ #category : #testing }
SpiderArena >> isValidePosition: pos [
	^ self minX @ self minY <= pos and: [ pos <= maxPos ]
]

{ #category : #accessing }
SpiderArena >> itemAt: cood [
	^ (items at: cood y) at: cood x
	
]

{ #category : #accessing }
SpiderArena >> itemAt: cood put: item [
	^ (items at: cood y) at: cood x put: item
	
]

{ #category : #accessing }
SpiderArena >> items [
	^ items
]

{ #category : #rendering }
SpiderArena >> lostGame [
	self withIndexItemsDo: [ :item :i :j |
		j = self maxY ifFalse: [ 
			self itemAt: i@j put: (SpiderExplode arena: self pos: i@j tick: 30) ] ]
]

{ #category : #configuration }
SpiderArena >> maxX [
	^ maxPos x
]

{ #category : #configuration }
SpiderArena >> maxY [
	^ maxPos y
]

{ #category : #configuration }
SpiderArena >> minX [
	^ 1
]

{ #category : #configuration }
SpiderArena >> minY [
	^ 1
]

{ #category : #collision }
SpiderArena >> missile: missile enter: cood [
	"We assume the coods are in-bounds"
	(self itemAt: cood) missileEnter: missile.
	
			
]

{ #category : #initialization }
SpiderArena >> newRandomSpiderTicked:  numTick [
	| randomX spider |
	[randomX := self randomX.
	(self itemAt: randomX @ 1) isEmpty] whileFalse.
	spider := SpiderSpider arena: self pos: randomX @ self minY tick: numTick.
	self setSpritePosition: spider to: spider pos
]

{ #category : #rendering }
SpiderArena >> paintFor: id [
	^ paints at: id
]

{ #category : #initialization }
SpiderArena >> randomX [
	^ self maxX atRandom - 1 + self minX
]

{ #category : #rendering }
SpiderArena >> removeMissile: missile [
	self removeSprite: missile.
	spaceShip reload.
]

{ #category : #rendering }
SpiderArena >> removeSprite: item [
	self itemAt: item pos put: (SpiderEmpty arena: self pos: item pos)
]

{ #category : #rendering }
SpiderArena >> renderOn: canvas [
	canvas setShape: (0@0 corner: 48@48).
	self withIndexItemsDo: [ :item :x :y |
		 item renderOn: canvas ]
]

{ #category : #accessing }
SpiderArena >> resourceManager: anObject [
	resourceManager := anObject
]

{ #category : #rendering }
SpiderArena >> setSpritePosition: item to: newPos [
	self removeSprite: item.
	self itemAt: newPos put: item.
	item pos: newPos
]

{ #category : #accessing }
SpiderArena >> spaceShip [
	^ spaceShip
]

{ #category : #collision }
SpiderArena >> spider: spider enter: cood [
	(self itemAt: cood) spiderEnter: spider
	
			
]

{ #category : #configuration }
SpiderArena >> spriteSize [
	^ resourceManager spriteSize
]

{ #category : #iterating }
SpiderArena >> withIndexItemsDo: aBlock [
	self minY to: self maxY do: [ :j |
		self minX to: self maxX do: [ :i |
			aBlock value: (self itemAt: i@j) value: i value: j ] ]
]
