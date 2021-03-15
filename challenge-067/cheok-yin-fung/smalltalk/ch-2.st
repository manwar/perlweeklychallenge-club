"GNU Smalltalk 3.2.5"
"The Weekly Challenge 067 Task 2"
"Letter Phone"
"Usage: gst -S ch-2.st"
"written on 27th Jan 2021"

'Integers composed of the digit 2 to 9: ' printNl.
myI := stdin nextLine.

board := Dictionary new.
board at: $2 put:#($A $B $C).
board at: $3 put:#($D $E $F).
board at: $4 put:#($G $H $I).
board at: $5 put:#($J $K $L).
board at: $6 put:#($M $N $O).
board at: $7 put:#($P $Q $R $S).
board at: $8 put:#($T $U $V).
board at: $9 put:#($W $X $Y $Z).

mySet := Set new.
myNewSet := Set new.
myNewSet add: ''.

1 to: (myI size) do:
  [:index|
    c := myI at: index.
    mySet := myNewSet copy.
    myNewSet empty.
    (board at: c) do: [
      :each |
        mySet do: [
          :term|
          s := (term, each displayString).
          myNewSet add: s.
      ]
    ]
  ].

myNewSet printNl.

ObjectMemory quit.
