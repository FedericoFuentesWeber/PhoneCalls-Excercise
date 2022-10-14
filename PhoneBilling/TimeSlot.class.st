Class {
	#name : #TimeSlot,
	#superclass : #Object,
	#instVars : [
		'day',
		'startingTime',
		'endingTime'
	],
	#category : #PhoneBilling
}

{ #category : #'instance creation' }
TimeSlot class >> on: aDay startingAt: startTime endingAt: endTime [

	^self new
				initializeOn: aDay 
				startingAt: startTime 
				endingAt: endTime
]

{ #category : #accessing }
TimeSlot >> day [

	^day
]

{ #category : #calculating }
TimeSlot >> durationOfCallFrom: startTime to: endTime [ 
	
	^(self includes: startTime andAlso: endTime)
		ifTrue: [ (self quantityOfMinutesFrom: startTime to: endTime) ]
		ifFalse: [ (self includes: startTime andNot: endTime)
				ifTrue: [ (self quantityOfMinutesFrom: startTime to: endingTime ) ]
				ifFalse: [ (self isNotIncluded: startTime butDoesInclude: endTime)
						ifTrue: [ (self quantityOfMinutesFrom: startingTime to: endTime ) ]
						ifFalse: [0]]]
				
	
]

{ #category : #accessing }
TimeSlot >> endingTime [

	^endingTime 
]

{ #category : #accessing }
TimeSlot >> includes: startTime andAlso: endTime [

	^(self startTime <= startTime) and: [self endingTime >= endTime]
]

{ #category : #accessing }
TimeSlot >> includes: startTime andNot: endTime [

	^(startTime between: self startTime and: self endingTime) and: [self endingTime < endTime]
]

{ #category : #initialization }
TimeSlot >> initializeOn: aDay startingAt: startTime endingAt: endTime [

	day:= aDay.
	startingTime:= startTime.
	endingTime:= endTime 
]

{ #category : #accessing }
TimeSlot >> isNotIncluded: startTime butDoesInclude: endTime [

	^self startTime > startTime and: [endTime  between: self startTime  and:  self endingTime ]
]

{ #category : #calculating }
TimeSlot >> quantityOfMinutesFrom: startTime to: endTime [

	^(endTime asDuration - startTime asDuration)asMinutes ceiling
]

{ #category : #accessing }
TimeSlot >> startTime [

	^startingTime 
]
