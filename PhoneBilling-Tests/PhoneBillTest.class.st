Class {
	#name : #PhoneBillTest,
	#superclass : #TestCase,
	#category : #'PhoneBilling-Tests'
}

{ #category : #'private accessing' }
PhoneBillTest >> phoneBillWithOneNationalCallAndOneInternationalCallAnd100OfBasicPayment [

	^PhoneBill
		forAll: (Array 
							with: (PhoneCallCost of: (NationalPhoneCall withLocation: 'Lomas de Zamora') is: 10)
							with: (PhoneCallCost of: (InternationalPhoneCall withCountry: 'Noruega') is: 150 ))
		withBasicMonthlyPayment: 100
]

{ #category : #'private accessing' }
PhoneBillTest >> phoneBillWithOneOfEachTypeOfPhoneCall [
	
	^PhoneBill 
		forAll: (Array 
							with: (PhoneCallCost of: (LocalPhoneCall 
																			onDay: 'Monday' 
																			at: (Time hour: 9 minute: 0 second: 0) 
																			andEnding: (Time hour: 15 minute: 0 second: 0))
																is: 50)
							with: (PhoneCallCost of: (NationalPhoneCall withLocation: 'Lomas de Zamora') is: 10)
							with: (PhoneCallCost of: (InternationalPhoneCall withCountry: 'Francia') is: 150))
		withBasicMonthlyPayment: 100
]

{ #category : #'private accessing' }
PhoneBillTest >> phoneBillWithTwoNationalCallsAnd100OfBasicPayment [
	
	^PhoneBill 
		forAll: (Array 
							with: (PhoneCallCost of: (NationalPhoneCall withLocation: 'Lomas de Zamora') is: 10)
							with: (PhoneCallCost of: (NationalPhoneCall withLocation: 'Adrogue') is: 15)) 
		withBasicMonthlyPayment: 100
							
]

{ #category : #tests }
PhoneBillTest >> test01BasicMonthlyPaymentMustBePositive [

	self
		should: [ PhoneBill 
							forAll: Array new
							withBasicMonthlyPayment: -1. ]
		raise: Error 
			withExceptionDo: [ :error | 
				self
					assert: error messageText
					equals: 'Monthly payment must be positive.' ]
]

{ #category : #tests }
PhoneBillTest >> test02PrintAPhoneBillWithoutCalls [

	|bill expectedResult|
		
	bill := PhoneBill 
						forAll: Array new
						withBasicMonthlyPayment: 100.
	
	expectedResult := '	Basic payment: 100
	Total charged: 100'.
	
	self assert: bill asString equals: expectedResult
]

{ #category : #tests }
PhoneBillTest >> test03PrintAPhoneBillWithTwoNationalCalls [

	|bill expectedResult|
	
	bill := self phoneBillWithTwoNationalCallsAnd100OfBasicPayment.
	
	expectedResult := '	Basic payment: 100
	National phone calls: 25
		National phone call to: Lomas de Zamora - Cost: 10
		National phone call to: Adrogue - Cost: 15
	Total charged: 125'.
	
	self assert: bill asString equals: expectedResult
]

{ #category : #tests }
PhoneBillTest >> test04PrintAPhoneBillWithOneNationalCallAndOneInternationalCall [

	|bill expectedResult|
	
	bill := self phoneBillWithOneNationalCallAndOneInternationalCallAnd100OfBasicPayment.
	
	expectedResult := '	Basic payment: 100
	National phone call: 10
		National phone call to: Lomas de Zamora - Cost: 10
	International phone call: 150
		International phone call to: Noruega - Cost: 150
	Total charged: 260'.
	
	self assert: bill asString equals: expectedResult
]

{ #category : #tests }
PhoneBillTest >> test05PrintAPhoneBillWithOneOfEachTypeOfPhoneCall [

	|bill expectedResult|
	
	bill := self phoneBillWithOneOfEachTypeOfPhoneCall.
	
	expectedResult := '	Basic payment: 100
	Local phone call: 50
		Local phone call on: Monday, starting at: 9:00 am and ending at: 3:00 pm - Cost: 50
	National phone call: 10
		National phone call to: Lomas de Zamora - Cost: 10
	International phone call: 150
		International phone call to: Francia - Cost: 150
	Total charged: 310'.
	
	self assert: bill asString equals: expectedResult
]
