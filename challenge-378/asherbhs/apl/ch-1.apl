⎕IO←0

SecondLargestDigit←{1⊃⌽¯1 ¯1,⎕D⍳⎕D∩⍵}

⎕←SecondLargestDigit 'aaaaa77777'
⎕←SecondLargestDigit 'abcde'
⎕←SecondLargestDigit '9zero8eight7seven9'
⎕←SecondLargestDigit 'xyz9876543210'
⎕←SecondLargestDigit '4abc4def2ghi8jkl2'
