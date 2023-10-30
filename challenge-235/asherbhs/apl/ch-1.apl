#!/usr/bin/env dyalogscript

RemoveOne←{∨/∧/2</⍵/⍨⍤1∘.≠⍨⍳≢⍵}

⎕←RemoveOne 0 2 9 4 6
⎕←RemoveOne 5 1 3 2
⎕←RemoveOne 2 2 3
