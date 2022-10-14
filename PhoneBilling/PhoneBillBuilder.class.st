Class {
	#name : #PhoneBillBuilder,
	#superclass : #Object,
	#instVars : [
		'basicMonthlyPayment',
		'phoneCalls'
	],
	#category : #PhoneBilling
}

{ #category : #building }
PhoneBillBuilder >> buildUsing: aCostRegistry [

	^PhoneBill
		forAll: (self phoneCallCostOfAll: phoneCalls using: aCostRegistry)
		withBasicMonthlyPayment: basicMonthlyPayment
]

{ #category : #configuring }
PhoneBillBuilder >> configureBasicMonthlyPayment: anAmount [

	basicMonthlyPayment := anAmount
]

{ #category : #configuring }
PhoneBillBuilder >> configurePhoneCalls: aCollectionOfPhonecalls [ 
	
	phoneCalls := aCollectionOfPhonecalls
]

{ #category : #initialization }
PhoneBillBuilder >> initialize [

	basicMonthlyPayment := 0.
	phoneCalls := OrderedCollection new
]

{ #category : #accessing }
PhoneBillBuilder >> phoneCallCostOfAll: phoneCallsCollection using: aCostRegistry [
	
	^phoneCallsCollection collect: [ :phoneCall | PhoneCallCost of: phoneCall is: (phoneCall costUsing: aCostRegistry)]
]
