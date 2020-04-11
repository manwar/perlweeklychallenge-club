 FlipBinary←{
⍝ ⍵: Binary number b of length n
     n←≢b←⍵
⍝ Flip 2 indices L≤R<N and count the number of 1s
⍝ ←: L R pairs which result in maximum 1s
     To←{⍺+⍳1+⍵-⍺}         ⍝ Integers ⍺ to ⍵ inclusive
     flip←{⍵/⍨≤/¨⍵},⍳n n   ⍝ Possible flip indices L R
     flerp←(⊃To/)¨flip     ⍝ Interpolate integers from L to R
     f←⍵∘{~@⍵⊢⍺}¨flerp     ⍝ b flipped at each set of flip indices
     max←⌈/sum←+/¨f        ⍝ Maximum number of 1s
     flip[⍸sum=max]        ⍝ Flip indices which result in maximum 1s
 }
