Class {
	#name : #PhoneCallsRegistry,
	#superclass : #Object,
	#instVars : [
		'phoneCalls'
	],
	#category : #PhoneBilling
}

{ #category : #initialization }
PhoneCallsRegistry >> initialize [ 

	phoneCalls := OrderedCollection new
]

{ #category : #accessing }
PhoneCallsRegistry >> phoneCalls [
	^ phoneCalls
]

{ #category : #registration }
PhoneCallsRegistry >> registerPhoneCall: aPhoneCall [ 
	
	phoneCalls add: aPhoneCall
]
