Class {
	#name : #PhoneCallCost,
	#superclass : #Object,
	#instVars : [
		'phoneCall',
		'cost'
	],
	#category : #PhoneBilling
}

{ #category : #'instance creation' }
PhoneCallCost class >> of: aPhoneCall is: anAmount [

	^self new
					initializeOf: aPhoneCall 
					is: anAmount
]

{ #category : #accessing }
PhoneCallCost >> cost [

	^cost
]

{ #category : #initialization }
PhoneCallCost >> initializeOf: aPhoneCall is: anAmount [

	phoneCall := aPhoneCall.
	cost := anAmount
]

{ #category : #accessing }
PhoneCallCost >> phoneCall [
	^ phoneCall
]

{ #category : #printing }
PhoneCallCost >> printOn: aStream [

	aStream 
			print: phoneCall;
			nextPutAll: ' - Cost: ';
			nextPutAll: cost asString
]
