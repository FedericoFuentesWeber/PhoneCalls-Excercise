Class {
	#name : #NationalPhoneCall,
	#superclass : #PhoneCall,
	#instVars : [
		'location'
	],
	#category : #PhoneBilling
}

{ #category : #'instance creation' }
NationalPhoneCall class >> withLocation: aLocation [

 ^self new
					initializeWithLocation: aLocation
]

{ #category : #accessing }
NationalPhoneCall >> costUsing: aCostRegistry [

	^aCostRegistry costForNationalPhoneCall: self
	
	
]

{ #category : #initialization }
NationalPhoneCall >> initializeWithLocation: aLocation [
 
 location:= aLocation
]

{ #category : #accessing }
NationalPhoneCall >> location [
	^ location
]

{ #category : #printing }
NationalPhoneCall >> printOn: aStream [

	aStream
				nextPutAll: 'National phone call to: ';
				nextPutAll: location
]

{ #category : #accessing }
NationalPhoneCall >> type [
	^'National phone call'
]
