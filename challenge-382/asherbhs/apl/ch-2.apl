⎕IO←0

ReplaceQuestionMark←{
	m←⍵='?'
	n←+/m
	↓'01'[⍉(n/2)⊤⍳2*n](⊣@{m}⍤1)⍵
}

⎕←ReplaceQuestionMark '01??0'
⎕←ReplaceQuestionMark '101'
⎕←ReplaceQuestionMark '???'
⎕←ReplaceQuestionMark '1?10'
⎕←ReplaceQuestionMark '1?1?0'
