Class {
	#name : #PhoneBillBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'costRegistry',
		'phoneCallsRegistry',
		'phoneBillBuilder'
	],
	#category : #'PhoneBilling-Tests'
}

{ #category : #'private accessing' }
PhoneBillBuilderTest >> mondayFirstTimeSlot [
	^TimeSlot on: 'Monday' startingAt: (Time hour: 8 minute: 0 second: 0) endingAt: (Time hour: 12 minute: 0 second: 0)
]

{ #category : #'private accessing' }
PhoneBillBuilderTest >> mondaySecondTimeSlot [
	^TimeSlot on: 'Monday' startingAt: (Time hour: 12 minute: 0 second: 0) endingAt: (Time hour: 15 minute: 0 second: 0)
]

{ #category : #initialization }
PhoneBillBuilderTest >> setUp [

	super setUp.
	costRegistry := CostRegistry new.
	phoneCallsRegistry := PhoneCallsRegistry new.
	phoneBillBuilder := PhoneBillBuilder new
]

{ #category : #tests }
PhoneBillBuilderTest >> test01PhoneBillWithoutPhoneCalls [

	|phoneBill basicPayment|
	

	basicPayment := 200.
	
	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			buildUsing: costRegistry.
	
	self assert: phoneBill basicMonthlyPayment equals: basicPayment;
			assertEmpty: phoneBill phoneCallCosts;
			assert: phoneBill totalChargedAtTheEndOfTheMonth equals: basicPayment.
]

{ #category : #tests }
PhoneBillBuilderTest >> test02PhoneBillWithOneLocalPhoneCallInOneTimeSlot [

	| phoneBill phoneCallCost basicPayment firstLocalPhoneCall secondLocalPhoneCall|
	
	basicPayment := 100.
	phoneCallCost := (1/5 * 3* 60) + (1/5 *1 *60).
	
	firstLocalPhoneCall := LocalPhoneCall onDay: 'Monday' at: (Time hour: 9 minute: 0 second: 0) andEnding: (Time hour: 12 minute: 0 second: 0).
	secondLocalPhoneCall := LocalPhoneCall onDay: 'Monday' at: (Time hour: 10 minute: 0 second: 0) andEnding: (Time hour: 11 minute: 0 second: 0).
	
	phoneCallsRegistry registerPhoneCall: firstLocalPhoneCall;
									registerPhoneCall: secondLocalPhoneCall.
	costRegistry registerTimeSlot: self mondayFirstTimeSlot costingPerMinute: 1/5.

	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			configurePhoneCalls: phoneCallsRegistry phoneCalls;
			buildUsing: costRegistry.
	
	self
		assert: phoneBill basicMonthlyPayment equals: basicPayment;
		assert: phoneBill phoneCallCosts size equals: 2;
		assert: phoneBill totalChargedAtTheEndOfTheMonth  equals: basicPayment + phoneCallCost.
]

{ #category : #tests }
PhoneBillBuilderTest >> test03PhoneBillWithManyLocalPhoneCallInOneTimeSlot [

	| phoneBill phoneCallCost basicPayment firstLocalPhoneCall secondLocalPhoneCall|
	
	basicPayment := 100.
	phoneCallCost := (1/5 * 3 * 60) + (1/5 * 1 * 60).
	
	firstLocalPhoneCall := LocalPhoneCall onDay: 'Monday' at: (Time hour: 9 minute: 0 second: 0) andEnding: (Time hour: 12 minute: 0 second: 0).
	secondLocalPhoneCall := LocalPhoneCall onDay: 'Monday' at: (Time hour: 10 minute: 0 second: 0) andEnding: (Time hour: 11 minute: 0 second: 0).
	
	phoneCallsRegistry registerPhoneCall: firstLocalPhoneCall;
									registerPhoneCall: secondLocalPhoneCall.
	costRegistry registerTimeSlot: self mondayFirstTimeSlot costingPerMinute: 1/5.

	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			configurePhoneCalls: phoneCallsRegistry phoneCalls;
			buildUsing: costRegistry.
	
	self
		assert: phoneBill basicMonthlyPayment equals: basicPayment;
		assert: phoneBill phoneCallCosts size equals: 2;
		assert: phoneBill totalChargedAtTheEndOfTheMonth  equals: basicPayment + phoneCallCost.
]

{ #category : #tests }
PhoneBillBuilderTest >> test04PhoneBillWithOneLocalPhoneCallInMoreThanOneTimeSlot [

	|phoneBill phoneCallCost basicPayment localPhoneCall|
	
	basicPayment := 100.
	phoneCallCost := (1/5 * 3* 60) + (1/6 * 2 *60).
	
	localPhoneCall := LocalPhoneCall onDay: 'Monday' at: (Time hour: 9 minute: 0 second: 0) andEnding: (Time hour: 14 minute: 0 second: 0).
	
	phoneCallsRegistry registerPhoneCall: localPhoneCall.
	costRegistry registerTimeSlot: self mondayFirstTimeSlot costingPerMinute: 1/5;
						 registerTimeSlot: self mondaySecondTimeSlot costingPerMinute: 1/6.
	
	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			configurePhoneCalls: phoneCallsRegistry phoneCalls;
			buildUsing: costRegistry.
	
	self
		assert: phoneBill basicMonthlyPayment equals: basicPayment;
		assert: phoneBill phoneCallCosts size equals: 1;
		assert: phoneBill totalChargedAtTheEndOfTheMonth equals: basicPayment + phoneCallCost.
]

{ #category : #tests }
PhoneBillBuilderTest >> test05PhoneBillWithOneNationalPhoneCall [

	|phoneBill phoneCallCost basicPayment nationalPhoneCall|
	
	basicPayment := 100.
	phoneCallCost := 20.
	
	nationalPhoneCall := NationalPhoneCall withLocation: 'Lomas de Zamora'.
	
	phoneCallsRegistry registerPhoneCall: nationalPhoneCall.
	costRegistry  registerLocation: 'Lomas de Zamora' withCost: phoneCallCost.
	
	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			configurePhoneCalls: phoneCallsRegistry phoneCalls;
			buildUsing: costRegistry.
	
	self
		assert: phoneBill basicMonthlyPayment equals: basicPayment;
		assert: phoneBill phoneCallCosts size equals: 1;
		assert: phoneBill totalChargedAtTheEndOfTheMonth  equals: basicPayment + phoneCallCost.
]

{ #category : #tests }
PhoneBillBuilderTest >> test06PhoneBillWithManyNationalPhoneCalls [

	|phoneBill phoneCallCost basicPayment firstNationalPhoneCall secondNationalPhoneCall|
	
	basicPayment := 100.
	phoneCallCost := 20.
	
	firstNationalPhoneCall := NationalPhoneCall withLocation: 'Lomas de Zamora'.
	secondNationalPhoneCall := NationalPhoneCall withLocation: 'Once'.
	
	phoneCallsRegistry registerPhoneCall: firstNationalPhoneCall;
									registerPhoneCall: secondNationalPhoneCall.
	costRegistry registerLocation: 'Lomas de Zamora' withCost: 20;
						 registerLocation: 'Once' withCost: 50.
	
	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			configurePhoneCalls: phoneCallsRegistry phoneCalls;
			buildUsing: costRegistry.
	
	self
		assert: phoneBill basicMonthlyPayment equals: basicPayment;
		assert: phoneBill phoneCallCosts size equals: 2;
		assert: phoneBill totalChargedAtTheEndOfTheMonth equals: basicPayment + 70.
]

{ #category : #tests }
PhoneBillBuilderTest >> test07PhoneBillWithOneInternationalPhoneCall [

	|phoneBill basicPayment internationalPhoneCall|
	
	basicPayment := 100.
	
	internationalPhoneCall := InternationalPhoneCall withCountry: 'Alemania'.

	phoneCallsRegistry registerPhoneCall: internationalPhoneCall.
	costRegistry registerCountry: 'Alemania' withCost: 100.
	
	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			configurePhoneCalls: phoneCallsRegistry phoneCalls;
			buildUsing: costRegistry.
	
	self
		assert: phoneBill basicMonthlyPayment equals: basicPayment;
		assert: phoneBill phoneCallCosts size equals: 1;
		assert: phoneBill totalChargedAtTheEndOfTheMonth equals: basicPayment + 100.
]

{ #category : #tests }
PhoneBillBuilderTest >> test08PhoneBillWithManyInternationalPhoneCalls [

	|phoneBill basicPayment firstInternationalPhoneCall secondInternationalPhoneCall|
	
	basicPayment := 100.
	
	firstInternationalPhoneCall := InternationalPhoneCall withCountry: 'Alemania'.
	secondInternationalPhoneCall := InternationalPhoneCall withCountry: 'España'.
	
	phoneCallsRegistry registerPhoneCall: firstInternationalPhoneCall;
									registerPhoneCall: secondInternationalPhoneCall.
	costRegistry registerCountry: 'Alemania' withCost: 100;
						 registerCountry: 'España' withCost: 50.
	
	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			configurePhoneCalls: phoneCallsRegistry phoneCalls;
			buildUsing: costRegistry.
	
	self
		assert: phoneBill basicMonthlyPayment equals: basicPayment;
		assert: phoneBill phoneCallCosts size equals: 2;
		assert: phoneBill totalChargedAtTheEndOfTheMonth equals: basicPayment + 150.
]

{ #category : #tests }
PhoneBillBuilderTest >> test09PhoneBillWithOneNationalAndOneInternationalPhoneCall [

	|phoneBill basicPayment internationalPhoneCall nationalPhoneCall|
	
	basicPayment := 100.
	
	internationalPhoneCall := InternationalPhoneCall withCountry: 'Alemania'.
	nationalPhoneCall := NationalPhoneCall withLocation: 'Lugano'.
	
	phoneCallsRegistry registerPhoneCall: internationalPhoneCall;
									registerPhoneCall: nationalPhoneCall.
	costRegistry registerCountry: 'Alemania' withCost: 100;
						 registerLocation: 'Lugano' withCost: 10.
	
	phoneBill := 
		phoneBillBuilder 
			configureBasicMonthlyPayment: basicPayment;
			configurePhoneCalls: phoneCallsRegistry phoneCalls;
			buildUsing: costRegistry.
	
	self
		assert: phoneBill basicMonthlyPayment equals: basicPayment;
		assert: phoneBill phoneCallCosts size equals: 2;
		assert: phoneBill totalChargedAtTheEndOfTheMonth equals: basicPayment + 110.
]
