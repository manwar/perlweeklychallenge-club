⎕IO←0
'displayr' 'cmpx'⎕cy'dfns'

⍝ uses some funky reshapes
OrderGame1←{
	n←≢⍵
	n≤1: ⍬
	⌊/⊃{
		(x y)←⊂⍤2⊢1 0 2⍉⍵⍴⍨⍺,2 2
		,⍉↑(⌊/x)(⌈/y)
	}/(2*⍳(n≥4)×¯1+2⍟n),⊂⍵
}

⍝ perhaps more natural, but much slower
OrderGame2←{
	⊃{
		p←↓(⊢⍴⍨2,⍨≢÷2⍨)⍵    ⍝ ⊂⍤⊢⌺(⍪2 2)⊢⍵
		m←2|⍳≢p
		⌈/¨@{m}⌊/¨@{~m}p
	}⍣(2⍟≢⍵)⊢⍵
}

⍝ thought this could be faster but it's actually slower
OrderGame3←{
	t←⍵,⍨0⍴⍨¯2+≢⍵
	_←2{
		i←(⍺-2)+4×⍳⍺÷4
		j←(⍵-2)+2×⍳⍵÷2
		t[j  ]←t[i  ]⌊t[i+1]
		t[j+1]←t[i+2]⌈t[i+3]
		⍬
	}/⌽2*1+⍳2⍟≢⍵
	⌊/2↑t
}

⍝ slightly faster version of 2
OrderGame4←{
	⊃{
		m←⍬
		⌈/¨@{m}⌊/¨@{~m⊢←2|⍳≢⍵}↓(⊢⍴⍨2,⍨≢÷2⍨)⍵
	}⍣(2⍟≢⍵)⊢⍵
}

⎕←OrderGame1 2 1 4 5 6 3 0 2
⎕←OrderGame2 2 1 4 5 6 3 0 2
⎕←OrderGame3 2 1 4 5 6 3 0 2
⎕←OrderGame4 2 1 4 5 6 3 0 2

⎕←OrderGame1 0 5 3 2
⎕←OrderGame2 0 5 3 2
⎕←OrderGame3 0 5 3 2
⎕←OrderGame4 0 5 3 2

⎕←OrderGame1 9 2 1 4 5 6 0 7 3 1 3 5 7 9 0 8
⎕←OrderGame2 9 2 1 4 5 6 0 7 3 1 3 5 7 9 0 8
⎕←OrderGame3 9 2 1 4 5 6 0 7 3 1 3 5 7 9 0 8
⎕←OrderGame4 9 2 1 4 5 6 0 7 3 1 3 5 7 9 0 8

⍝ x←?1e4⍴⍨⎕←2*20
⍝ ⎕profile 'start'
⍝ ⎕←cmpx 1 0 1 0/'OrderGame1 x' 'OrderGame2 x' 'OrderGame3 x' 'OrderGame4 x'
⍝ ⎕profile 'stop'
⍝ ⎕←⎕profile 'data'
