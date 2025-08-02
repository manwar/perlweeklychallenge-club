MakingChange←{
	⎕IO←0
	n←⍵
	n=0: 1
	t←1↑⍨n+1
	_←{
		c←⍵
		{{t[⍵]+←t[⍵-c]}⍣(⍵≥c)⊢⍵}¨1+⍳n
	}¨1 5 10 25 50
	⊃⌽t
}

⎕←MakingChange 9
⎕←MakingChange 15
⎕←MakingChange 100
