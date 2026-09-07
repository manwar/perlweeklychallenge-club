RearrangeBinaryString←{
	n←0
	_←{
		n+←1
		(¯1⌽m)≠⍵∨m←0 1⍷⍵
	}⍣≡⍵='1'
	n-1
}

⎕←RearrangeBinaryString '111000'
⎕←RearrangeBinaryString '00011'
⎕←RearrangeBinaryString '01011'
⎕←RearrangeBinaryString '010101'
⎕←RearrangeBinaryString '00001'
