SumOfFrequencies←{(a∊'aeiou')(/+⍥(⌈/)~⍛/)+⌿⍵∘.=a←⎕C⎕A}

⎕←SumOfFrequencies 'banana'
⎕←SumOfFrequencies 'teestett'
⎕←SumOfFrequencies 'aeiouuaa'
⎕←SumOfFrequencies 'rhythm'
⎕←SumOfFrequencies ,'x'
