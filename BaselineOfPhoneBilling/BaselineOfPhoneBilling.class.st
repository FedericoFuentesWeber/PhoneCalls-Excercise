Class {
	#name : #BaselineOfPhoneBilling,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhoneBilling
}

{ #category : #baselines }
BaselineOfPhoneBilling >> baseline: spec [

	<baseline>
    spec for: #common do: [	
				
        "Packages"
        spec
            package: 'PhoneBilling';
            package: 'PhoneBilling-Tests' with: [ spec requires: 'PhoneBilling' ] ].
]

{ #category : #accessing }
BaselineOfPhoneBilling >> projectClass [

	^ MetacelloCypressBaselineProject
]
