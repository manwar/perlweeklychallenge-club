CountWords ← {+/⊃¨⍺∘⍷¨⍵}

⍝ Tests

'at' CountWords 'pay' 'attention' 'practice' 'attend' 'cat' ⍝ 2
'ja' CountWords 'janet' 'julia' 'java' 'javascript'         ⍝ 3
