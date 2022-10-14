Class {
	#name : #PhoneCallsRegistryTest,
	#superclass : #TestCase,
	#category : #'PhoneBilling-Tests'
}

{ #category : #tests }
PhoneCallsRegistryTest >> test01RegisterLocalPhoneCall [

	|localPhoneCall phoneCallRegistry startDateAndTime endDateAndTime|
	
	startDateAndTime:= DateAndTime now.
	endDateAndTime:= DateAndTime now + 1 hour.
	localPhoneCall:= LocalPhoneCall onDay: 'Monday' at: startDateAndTime andEnding: endDateAndTime.
	
	phoneCallRegistry := PhoneCallsRegistry new.
	phoneCallRegistry registerPhoneCall: localPhoneCall.
	
	self assert: phoneCallRegistry phoneCalls size equals: 1
]

{ #category : #tests }
PhoneCallsRegistryTest >> test02RegisterNationalPhoneCall [

	|nationalCall phoneCallRegistry aLocation|
	
	aLocation:= 'Lomas de Zamora'.
	nationalCall:= NationalPhoneCall withLocation: aLocation.
	
	phoneCallRegistry := PhoneCallsRegistry new.
	phoneCallRegistry registerPhoneCall: nationalCall.
	
	self assert: phoneCallRegistry phoneCalls size equals: 1
]

{ #category : #tests }
PhoneCallsRegistryTest >> test03RegisterInternationalPhoneCall [

	|internationalCall phoneCallRegistry aCountry|
	
	aCountry:= 'España'.
	internationalCall:= InternationalPhoneCall withCountry: aCountry.
	
	phoneCallRegistry := PhoneCallsRegistry new.
	phoneCallRegistry registerPhoneCall: internationalCall.
	
	self assert: phoneCallRegistry phoneCalls size equals: 1
]
