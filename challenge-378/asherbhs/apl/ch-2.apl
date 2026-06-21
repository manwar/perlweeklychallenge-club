⎕IO←0

SumOfWords←{
	(a b c)←(10⊥(⎕C⎕A)⍳⊢)¨⍵
	c=a+b
}

⎕←SumOfWords 'acb' 'cba'  'cdb'
⎕←SumOfWords 'aab' 'aac'  'ad'
⎕←SumOfWords 'bc'  'je'   'jg'
⎕←SumOfWords 'a'   'aaaa' 'aa'
⎕←SumOfWords 'c'   'd'    'h'
⎕←SumOfWords 'gfi' 'hbf'  'bdhd'
