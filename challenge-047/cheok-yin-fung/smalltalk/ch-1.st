"GNU Smalltalk 3.2.5"
"The Weekly Challenge 047 Task 1"
"Roman"
"Usage: gst -S ch-1.st"
"written on 28th Jan 2021"
"remark: 1. translate from the Perl codes, 
  2. need terminating methods "

'Roman numbers operation going to be done: (e.g._ V + VI _) ' printNl.
s := stdin nextLine.
parts := s substrings.
a1 := parts at: 1.
a2 := parts at: 3.
op := parts at: 2.

operation := Array new: 3.
operation at: 1 put: $+.
operation at: 2 put: $-.
operation at: 3 put: $*.

"TERMINATE if size of parts > 3"
"TERMINATE if op is not in the three allowed operators"


Number extend [
  romanized [
    | t word |
    t := self.
    word := ''.
    [t > 0] whileTrue: [
       ((t >= 1000)) ifTrue: [word := (word,'M'). t := t-1000].
       ((t >= 900) & (t < 1000)) ifTrue: [word := (word,'CM'). t := t-900].
       ((t >= 500) & (t < 900)) ifTrue: [word := (word,'D'). t := t-500].
       ((t >= 400) & (t < 500)) ifTrue: [word := (word,'DC'). t := t-400].
       ((t >= 100) & (t < 400)) ifTrue: [word := (word,'C'). t := t-100].
       ((t >= 90) & (t < 100)) ifTrue: [word := (word,'XC'). t := t-90].
       ((t >= 50) & (t < 90)) ifTrue: [word := (word,'L'). t := t-50].
       ((t >= 40) & (t < 50)) ifTrue: [word := (word,'XL'). t := t-40].
       ((t >= 10) & (t < 40)) ifTrue: [word := (word,'X'). t := t-10].
       (t = 9)           ifTrue: [word := (word,'IX'). t := t-9].
       ((t >= 5) & (t < 9)) ifTrue: [word := (word,'V'). t := t-5].
       (t = 4)          ifTrue: [word := (word,'IV'). t := t-4].
       ((t >= 1) & (t < 4)) ifTrue: [word := (word,'I'). t := t-1].
    ].
    (word = '') ifTrue: [word := 0].
    ^word
  ] 
]

String subclass: Roman [
  | word |
  <comment:
    'I represent a number string in Roman system.'>
  new [
    |r|
    <category: 'instance creation'>
    r := super new.
    r init.
    ^r
  ]
  init: myString [
    <category: 'initialization'>
    word := myString.
  ]
  value [
    |total romanChar|
    <category: 'method'>
    total := 0.
    romanChar := Dictionary new.
    romanChar at: $I put: 1.
    romanChar at: $V put: 5.
    romanChar at: $X put: 10.
    romanChar at: $L put: 50.
    romanChar at: $C put: 100.
    romanChar at: $D put: 500.
    romanChar at: $M put: 1000.
    1 to: (word size - 1) do: [:index|
      | c d |
      c := Character new.
      d := Character new.
      c := word at: index.
      d := word at: (index+1).
      total := total + (romanChar at: c).
      ( (romanChar at: c) < (romanChar at: d) ) ifTrue:
         [total := total - ( (romanChar at: c) * 2 ) .]
    ].
    total := total + (romanChar at: (word at: (word size))).
    ^total
  ]
].

s1 := Roman new.
s1 := s1 init: a1.
s2 := Roman new.
s2 := s2 init: a2.
fin := Number new.

(op='+') ifTrue: [fin := ((s1 value) + (s2 value))].
(op='-') ifTrue: [fin := ((s1 value) - (s2 value))].
(op='*') ifTrue: [fin := ((s1 value) * (s2 value))].

fin romanized printNl.

ObjectMemory quit.

