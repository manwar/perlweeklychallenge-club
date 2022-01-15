"GNU Smalltalk 3.2.5"
"The Weekly Challenge 147"
"Task 1 Truncatable Prime"
"Usage: gst -S ch-1.st"
"Thursday, January 13, 2022 PM20:30:44 UTC"

Smalltalk at: #Primes put: nil.

Ltp := OrderedCollection new.

RecentLtp := OrderedCollection with: 2 with: 3 with: 5 with: 7.

NewLtp := OrderedCollection new.

my_Primes := OrderedCollection with: 2 with: 3 with: 5 with: 7.

Smalltalk at: #Primes put: my_Primes.



Number extend [
    inc [
        ^(self+1)
    ]
    dec [
        ^(self-1)
    ]
    sqrt [  "Why there is no built-in float square root at GNU Smalltalk?"
        |smallNum|
        smallNum := 1.
        [smallNum squared > self] whileFalse: [smallNum := smallNum inc].
        ^(smallNum dec)
    ]
    isPrime [
        |b i|
        i := 1.
        [ (b := self \\ (Primes at: i) ~= 0) & (((Primes at: i) > self sqrt) not) ] whileTrue: [i := i inc].
         ^b
    ]
]



p := 10.

[p < 1000] whileTrue: [
    (p isPrime) ifTrue: [my_Primes add: p. Smalltalk at: #Primes put: my_Primes.].
    p := p inc
].



[Ltp size + RecentLtp size >= 20] whileFalse: [
    1 to: 9 do: [ :D |
        RecentLtp do: [ :Num |
            |NewNum|
            NewNum := ((D asString, Num asString) asInteger).
            (NewNum isPrime) ifTrue: [NewLtp add: NewNum]
        ].
    ].
    Ltp addAll: RecentLtp.
    RecentLtp := NewLtp.
    NewLtp := OrderedCollection new.
].

Ltp addAll: RecentLtp.

(Ltp copyFrom: 1 to: 20) printNl.

ObjectMemory quit.
