#!/usr/bin/env dyalogscript

DuplicateZeros←≢↑⊢⊢⍤/⍨1+0=⊢

⎕←DuplicateZeros 1 0 2 3 0 4 5 0
⎕←DuplicateZeros 1 2 3
⎕←DuplicateZeros 0 3 0 4 5
