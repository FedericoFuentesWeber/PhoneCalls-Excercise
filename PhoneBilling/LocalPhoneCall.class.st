Class {
	#name : #LocalPhoneCall,
	#superclass : #PhoneCall,
	#instVars : [
		'day',
		'startTime',
		'endTime'
	],
	#category : #PhoneBilling
}

{ #category : #'instance creation' }
LocalPhoneCall class >> onDay: aDay at: startingTime andEnding: endingTime [ 

	^self new
					initializeOnDay: aDay
					at: startingTime 
					andEnding: endingTime
]

{ #category : #accessing }
LocalPhoneCall >> costUsing: aCostRegistry [

	|timeSlot|
	timeSlot:= TimeSlot on: day startingAt: startTime endingAt: endTime.
	
	^aCostRegistry costForLocalPhoneCall: self
]

{ #category : #accessing }
LocalPhoneCall >> day [
	^ day
]

{ #category : #accessing }
LocalPhoneCall >> endTime [
	^ endTime
]

{ #category : #initialization }
LocalPhoneCall >> initializeOnDay: aDay at: startingTime andEnding: endingTime [

	day:= aDay.
	startTime:= startingTime.
	endTime:= endingTime  
]

{ #category : #printing }
LocalPhoneCall >> printOn: aStream [

	aStream
				nextPutAll: 'Local phone call on: ';
				nextPutAll: day;
				nextPutAll: ', starting at: ';
				nextPutAll: startTime asString;
				nextPutAll: ' and ending at: ';
				nextPutAll: endTime asString
]

{ #category : #accessing }
LocalPhoneCall >> startTime [

	^startTime 
]

{ #category : #accessing }
LocalPhoneCall >> type [
	^'Local phone call'
]
