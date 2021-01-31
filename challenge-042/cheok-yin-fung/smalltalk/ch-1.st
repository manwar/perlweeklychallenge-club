"GNU Smalltalk 3.2.5"
"The Weekly Challenge 042 Task 1"
"Octal Number System"
"Usage: gst -S ch-1.st"
"written on 28th Jan 2021"

Number extend [
  octal [
    |t w eightpow|
    t := self.
    eightpow := 8.
    w := ''.
    [t // eightpow > 0] whileTrue: [
      w := ( (t \\ eightpow) displayString, w ).
      t := t // 8.
      eightpow := eightpow * 8.
    ].
    w := ( (t \\ eightpow) displayString, w ).
    t := t // 8.
    ^w
  ]
]

0 to: 50 do: [:i | 
  ('decimal: ', i displayString, '   octal: ', i octal )printNl.
].

ObjectMemory quit.
