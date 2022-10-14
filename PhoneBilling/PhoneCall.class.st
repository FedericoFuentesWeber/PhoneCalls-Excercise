Class {
	#name : #PhoneCall,
	#superclass : #Object,
	#category : #PhoneBilling
}

{ #category : #accessing }
PhoneCall >> costUsing: aCostRegistry [

	^self subclassResponsibility 
	
	
]

{ #category : #accessing }
PhoneCall >> type [

	^self subclassResponsibility
]
