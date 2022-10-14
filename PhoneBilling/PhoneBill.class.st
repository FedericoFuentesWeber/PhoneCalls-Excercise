Class {
	#name : #PhoneBill,
	#superclass : #Object,
	#instVars : [
		'basicMonthlyPayment',
		'phoneCallCosts'
	],
	#category : #PhoneBilling
}

{ #category : #'instance creation' }
PhoneBill class >> forAll: aCollectionOfPhoneCallCost withBasicMonthlyPayment: anAmount [
	
	anAmount negative ifTrue: [ 
		Error signal: 'Monthly payment must be positive.' ].
	
	^self new initializeForAll: aCollectionOfPhoneCallCost withBasicMonthlyPayment: anAmount
]

{ #category : #accessing }
PhoneBill >> basicMonthlyPayment [
	^ basicMonthlyPayment
]

{ #category : #initialization }
PhoneBill >> initializeForAll: aCollectionOfPhoneCallCost withBasicMonthlyPayment: anAmount [

	phoneCallCosts := aCollectionOfPhoneCallCost.
	basicMonthlyPayment := anAmount
]

{ #category : #accessing }
PhoneBill >> phoneCallCosts [
	^ phoneCallCosts
]

{ #category : #printing }
PhoneBill >> print: aCollectionOfPhoneCallCost headedBy: aHeading on: aStream [
	
	aStream 
		tab; 
		nextPutAll: aHeading; 
		print: (self totalChargedOfAll: aCollectionOfPhoneCallCost);
		cr.
	
	aCollectionOfPhoneCallCost do:[:aPhoneCallCost | 
			aStream 
				tab; 
				tab; 
				print: aPhoneCallCost;
				cr]
]

{ #category : #printing }
PhoneBill >> printOn: aStream [

	| phoneCallCostsByType |
	aStream 
		tab;
		nextPutAll: 'Basic payment: ';
		print: self basicMonthlyPayment;
		cr.
		
	phoneCallCostsByType := phoneCallCosts groupedBy: [ :aPhoneCallCost | aPhoneCallCost phoneCall type ].
	phoneCallCostsByType keysAndValuesDo: [ :type :thePhoneCallCosts | 
		self print: thePhoneCallCosts headedBy: ((type asPluralBasedOn: thePhoneCallCosts), ': ') on: aStream ].
		
	aStream 
			tab;
			nextPutAll: 'Total charged: '; 
			print: self totalChargedAtTheEndOfTheMonth.
]

{ #category : #accessing }
PhoneBill >> totalChargedAtTheEndOfTheMonth [
	
	^self basicMonthlyPayment + self totalChargedOfAllPhoneCalls
]

{ #category : #accessing }
PhoneBill >> totalChargedOfAll: aCollectionOfPhoneCallCost [
	
	^ aCollectionOfPhoneCallCost sumNumbers: [:aPhoneCallCost | aPhoneCallCost cost ]
]

{ #category : #accessing }
PhoneBill >> totalChargedOfAllPhoneCalls [
	
	^ self totalChargedOfAll: phoneCallCosts
]
