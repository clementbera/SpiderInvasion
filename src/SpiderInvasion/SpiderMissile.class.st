"
Je represente la missile tire par le vaisseau.
"
Class {
	#name : #SpiderMissile,
	#superclass : #SpiderAnimatedItem,
	#category : #SpiderInvasion
}

{ #category : #testing }
SpiderMissile class >> drawable [
	^ true
]

{ #category : #'instance creation' }
SpiderMissile class >> resourceID [
	^ #missile
]

{ #category : #rendering }
SpiderMissile >> action [
	self y = arena minY
		ifTrue: [ arena removeMissile: self ]
		ifFalse: [ arena missile: self enter: pos - (0@1)]
	
]

{ #category : #rendering }
SpiderMissile >> missileEnter: missile [
	"Les missiles ne detruisent pas d'autres missiles"
]

{ #category : #rendering }
SpiderMissile >> spiderEnter: missile [
	"Rien a faire pour eviter que l'araignee esquive les missiles"
]
