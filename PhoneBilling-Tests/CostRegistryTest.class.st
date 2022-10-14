Class {
	#name : #CostRegistryTest,
	#superclass : #TestCase,
	#category : #'PhoneBilling-Tests'
}

{ #category : #'private accessing' }
CostRegistryTest >> restOfWeekdayTimeSlotCollection [

	|returnedCollection firstStartingTime firstEndingTime secondStartingTime secondEndingTime|
	
	returnedCollection:= OrderedCollection new.
	
	firstStartingTime:= Time hour: 0 minute: 0 second: 0.
	firstEndingTime:= Time hour: 7 minute: 59 second: 59.
	secondStartingTime:= Time hour: 20 minute: 0 second: 1.
	secondEndingTime:= Time hour: 23 minute: 59 second: 59.
	
	returnedCollection add: (TimeSlot on: 'Monday' startingAt: firstStartingTime  endingAt: firstEndingTime );
									add: (TimeSlot on: 'Tuesday' startingAt: firstStartingTime  endingAt: firstEndingTime );
									add: (TimeSlot on: 'Wednesday' startingAt: firstStartingTime  endingAt: firstEndingTime );
									add: (TimeSlot on: 'Thursday' startingAt: firstStartingTime  endingAt: firstEndingTime );
									add: (TimeSlot on: 'Friday' startingAt: firstStartingTime  endingAt: firstEndingTime );
									add: (TimeSlot on: 'Monday' startingAt: secondStartingTime  endingAt: secondEndingTime );
									add: (TimeSlot on: 'Tuesday' startingAt: secondStartingTime  endingAt: secondEndingTime );
									add: (TimeSlot on: 'Wednesday' startingAt: secondStartingTime  endingAt: secondEndingTime );
									add: (TimeSlot on: 'Thursday' startingAt: secondStartingTime  endingAt: secondEndingTime );
									add: (TimeSlot on: 'Friday' startingAt: secondStartingTime  endingAt: secondEndingTime ).
			
	^returnedCollection 	
]

{ #category : #tests }
CostRegistryTest >> test01CostWeekdayForTimeSlot [

	|costAdministrator startingTime endingTime expectedAmount costPerMinute localPhoneCall|
	
	costPerMinute:= 1/5.
	
	startingTime:= Time hour: 9 minute: 0 second: 0.
	endingTime:= Time hour: 15 minute: 0 second: 0.
	localPhoneCall := LocalPhoneCall onDay: 'Monday' at: startingTime andEnding: endingTime.
	
	costAdministrator:= CostRegistry new.
	self weekdayTimeSlotCollection do: [ :aTimeSlot | (costAdministrator registerTimeSlot: aTimeSlot costingPerMinute: costPerMinute )].
	
	expectedAmount:= costPerMinute * 60 * 6.
	
	self assert: (costAdministrator costForLocalPhoneCall: localPhoneCall) equals: expectedAmount
]

{ #category : #tests }
CostRegistryTest >> test02CostForARegisteredCountry [

	|costRegistry costPerMinute country internationalPhoneCall|
	
	costPerMinute:= 1/5.
	country:= 'España'.
	internationalPhoneCall := InternationalPhoneCall withCountry: country.
	
	costRegistry:= CostRegistry new.
	costRegistry registerCountry: country withCost: costPerMinute.
	
	self assert: (costRegistry costForInternationalPhoneCall: internationalPhoneCall) equals: costPerMinute 
]

{ #category : #tests }
CostRegistryTest >> test03CostForARegisteredLocation [

	|costSystem costPerMinute location nationalPhoneCall|
	
	costPerMinute:= 0.1 .
	location:= 'Lomas de Zamora'.
	nationalPhoneCall := NationalPhoneCall withLocation: location.
	
	costSystem:= CostRegistry new.
	costSystem registerLocation: location withCost: costPerMinute.
	
	self assert: (costSystem costForNationalPhoneCall: nationalPhoneCall) equals: costPerMinute 
]

{ #category : #tests }
CostRegistryTest >> test04CostForWeekendTimeSlot [

	|costSystem startingTime endingTime expectedAmount costPerMinute localPhoneCall|
	
	costPerMinute:= 0.1 .
	
	startingTime:= Time hour: 9 minute: 0 second: 0.
	endingTime:= Time hour: 15 minute: 0 second: 0.
	localPhoneCall := LocalPhoneCall onDay: 'Sunday' at: startingTime andEnding: endingTime.
	
	costSystem:= CostRegistry new.
	self weekendTimeSlotCollection do: [ :aTimeSlot | (costSystem registerTimeSlot: aTimeSlot costingPerMinute: costPerMinute )].
	
	expectedAmount:= costPerMinute * 60 * 6.
	
	self assert: (costSystem costForLocalPhoneCall: localPhoneCall) equals: expectedAmount
]

{ #category : #tests }
CostRegistryTest >> test05CostForNotRegisteredCountry [

	|costSystem internationalPhoneCall|
	
	internationalPhoneCall := InternationalPhoneCall withCountry: 'España'.
	
	costSystem:= CostRegistry new.
	
	self should: [ costSystem costForInternationalPhoneCall: internationalPhoneCall ]
			raise: Error 
			withExceptionDo: [ :error | self assert: error messageText equals: 'Country is not registered.' ]
]

{ #category : #tests }
CostRegistryTest >> test06CostForNotRegisteredLocation [

	|costSystem nationalPhoneCall|
	
	nationalPhoneCall := NationalPhoneCall withLocation: 'Lomas de Zamora'.
	
	costSystem:= CostRegistry new.
	
	self should: [ costSystem costForNationalPhoneCall: nationalPhoneCall ]
			raise: Error 
			withExceptionDo: [ :error | self assert: error messageText equals: 'Location is not registered.' ]
]

{ #category : #tests }
CostRegistryTest >> test07CostWeekdayNotBelongingToAnyTimeSlot [

	|costSystem startingTime endingTime expectedAmount costPerMinute localPhoneCall|
	
	costPerMinute:= 0.1 .
	
	startingTime:= Time hour: 21 minute: 0 second: 0.
	endingTime:= Time hour: 22 minute: 0 second: 0.
	localPhoneCall := LocalPhoneCall onDay: 'Monday' at: startingTime andEnding: endingTime.
	
	costSystem:= CostRegistry new.
	self weekdayTimeSlotCollection do: [ :aTimeSlot | (costSystem registerTimeSlot: aTimeSlot costingPerMinute: 1/5 )].
	self restOfWeekdayTimeSlotCollection do: [ :aTimeSlot | (costSystem registerTimeSlot: aTimeSlot costingPerMinute: 0.1 )].
	
	expectedAmount:= costPerMinute * 60 * 1.
	
	self assert: (costSystem costForLocalPhoneCall: localPhoneCall ) equals: expectedAmount
]

{ #category : #tests }
CostRegistryTest >> test08LocalPhoneCallCostStartingInATimeSlotAndEndingInAnotherOne [

	|costAdministrator startingTime endingTime expectedAmount localPhoneCall|
	
	
	startingTime:= Time hour: 19 minute: 0 second: 0.
	endingTime:= Time hour: 22 minute: 0 second: 0.
	localPhoneCall := LocalPhoneCall onDay: 'Monday' at: startingTime andEnding: endingTime.
	
	costAdministrator:= CostRegistry new.
	self weekdayTimeSlotCollection do: [ :aTimeSlot | (costAdministrator registerTimeSlot: aTimeSlot costingPerMinute: 1/5 )].
	self restOfWeekdayTimeSlotCollection do: [ :aTimeSlot | (costAdministrator registerTimeSlot: aTimeSlot costingPerMinute: 0.1 )].
	
	expectedAmount:= (1/5 *1 *60) +(0.1 * 60 * 2).
	
	self assert: (costAdministrator costForLocalPhoneCall: localPhoneCall ) equals: expectedAmount
]

{ #category : #'private accessing' }
CostRegistryTest >> weekdayTimeSlotCollection [

	|returnedCollection weekStartingTime weekEndingTime|
	
	returnedCollection:= OrderedCollection new.
	
	weekStartingTime:= Time hour: 8 minute: 0 second: 0.
	weekEndingTime:= Time hour: 20 minute: 0 second: 0.
	
	returnedCollection add: (TimeSlot on: 'Monday' startingAt: weekStartingTime  endingAt: weekEndingTime );
									add: (TimeSlot on: 'Tuesday' startingAt: weekStartingTime  endingAt: weekEndingTime );
									add: (TimeSlot on: 'Wednesday' startingAt: weekStartingTime  endingAt: weekEndingTime );
									add: (TimeSlot on: 'Thursday' startingAt: weekStartingTime  endingAt: weekEndingTime );
									add: (TimeSlot on: 'Friday' startingAt: weekStartingTime  endingAt: weekEndingTime ).
			
	^returnedCollection 	
]

{ #category : #'private accessing' }
CostRegistryTest >> weekendTimeSlotCollection [

	|returnedCollection weekendStartingTime weekendEndingTime|
	
	returnedCollection:= OrderedCollection new.

	weekendStartingTime:= Time hour: 0 minute: 0 second: 0.
	weekendEndingTime:= Time hour: 23 minute: 59 second: 59.
	
	returnedCollection add: (TimeSlot on: 'Satuday' startingAt: weekendStartingTime  endingAt: weekendEndingTime);
									add: (TimeSlot on: 'Sunday' startingAt: weekendStartingTime  endingAt: weekendEndingTime).
			
	^returnedCollection 	
]
