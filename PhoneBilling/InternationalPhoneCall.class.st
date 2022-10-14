Class {
	#name : #InternationalPhoneCall,
	#superclass : #PhoneCall,
	#instVars : [
		'country'
	],
	#category : #PhoneBilling
}

{ #category : #'instance creation' }
InternationalPhoneCall class >> withCountry: aCountry [

 ^self new
					initializeWithCountry: aCountry 
]

{ #category : #calculating }
InternationalPhoneCall >> costUsing: aCostRegistry [

	^aCostRegistry costForInternationalPhoneCall: self
]

{ #category : #accessing }
InternationalPhoneCall >> country [
	^ country
]

{ #category : #initialization }
InternationalPhoneCall >> initializeWithCountry: aCountry [

 country:= aCountry
]

{ #category : #printing }
InternationalPhoneCall >> printOn: aStream [

	aStream
				nextPutAll: 'International phone call to: ';
				nextPutAll: country
]

{ #category : #accessing }
InternationalPhoneCall >> type [
	^'International phone call'
]
