⎕IO←0

ReverseString←{⍵[⌈/⍛-⍳≢⍵]}

⎕←ReverseString ''
⎕←ReverseString 'reverse the given string'
⎕←ReverseString 'Perl is Awesome'
⎕←ReverseString 'v1.0.0-Beta!'
⎕←ReverseString 'racecar'
