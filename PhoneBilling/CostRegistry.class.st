Class {
	#name : #CostRegistry,
	#superclass : #Object,
	#instVars : [
		'costPerTimeSlot',
		'costPerLocation',
		'costPerCountry'
	],
	#category : #PhoneBilling
}

{ #category : #accessing }
CostRegistry >> costForInternationalPhoneCall: anInternationalPhoneCall [
	
	^costPerCountry at: anInternationalPhoneCall country ifAbsent: [ Error signal: 'Country is not registered.' ]
]

{ #category : #accessing }
CostRegistry >> costForLocalPhoneCall: aLocalPhoneCall [ 

	|timeSlotsCollection|
	
	timeSlotsCollection:=
				costPerTimeSlot keys
										select: [ :oneTimeSlot | oneTimeSlot day = aLocalPhoneCall day].
										

	^timeSlotsCollection sumNumbers: [:timeSlot | self costOfPhoneCallOn: timeSlot startingAt: aLocalPhoneCall startTime andEndingAt: aLocalPhoneCall endTime]
]

{ #category : #accessing }
CostRegistry >> costForNationalPhoneCall: aNationalPhoneCall [
	
	^costPerLocation at: aNationalPhoneCall location ifAbsent: [ Error signal: 'Location is not registered.' ]
]

{ #category : #calculating }
CostRegistry >> costOfPhoneCallOn: timeSlot startingAt: startingTime andEndingAt: endingTime [
	
	|costPerMinute totalDurationInTimeSlot|
	
	costPerMinute := costPerTimeSlot at: timeSlot.
	totalDurationInTimeSlot:= timeSlot durationOfCallFrom: startingTime to: endingTime.
	
	^totalDurationInTimeSlot * costPerMinute.
]

{ #category : #initialization }
CostRegistry >> initialize [ 

	costPerTimeSlot:= Dictionary new.
	costPerLocation:= Dictionary new.
	costPerCountry:= Dictionary new.
]

{ #category : #registration }
CostRegistry >> registerCountry: aCountry withCost: anAmount [
	
	costPerCountry at: aCountry put: anAmount
]

{ #category : #registration }
CostRegistry >> registerLocation: aLocation withCost: anAmount [

	costPerLocation at: aLocation put: anAmount
]

{ #category : #registration }
CostRegistry >> registerTimeSlot: aTimeSlot costingPerMinute: anAmount [

	costPerTimeSlot at: aTimeSlot put: anAmount 
]
