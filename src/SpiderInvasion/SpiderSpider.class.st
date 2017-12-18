"
Je represente une araignee qui descend.
"
Class {
	#name : #SpiderSpider,
	#superclass : #SpiderAnimatedItem,
	#category : #SpiderInvasion
}

{ #category : #testing }
SpiderSpider class >> drawable [
	^ true
]

{ #category : #'instance creation' }
SpiderSpider class >> resourceID [
	^ #spider
]

{ #category : #rendering }
SpiderSpider >> action [
	self y = arena maxY
		ifTrue: [ arena lostGame ]
		ifFalse: [ arena spider: self enter: pos + (0@1)]
	
	
]

{ #category : #rendering }
SpiderSpider >> die [
	super die.
	arena newRandomSpiderTicked: (tick - 1 max: 8)
	
]
