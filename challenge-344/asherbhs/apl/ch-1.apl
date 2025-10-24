ArrayFormCompute←{ns⊤⍨10⍴⍨1+⌊10⍟ns←⍺+10⊥⍵}

⎕←  12 ArrayFormCompute   1 2 3 4
⎕← 181 ArrayFormCompute     2 7 4
⎕←   1 ArrayFormCompute     9 9 9
⎕←9999 ArrayFormCompute 1 0 0 0 0
⎕←1000 ArrayFormCompute         0
