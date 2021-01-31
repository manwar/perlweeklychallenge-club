"GNU Smalltalk 3.2.5"
"The Weekly Challenge 071 Task 2"
"Trim Linked List"
"Usage: gst -S ch-2.st"
"written on 30th Jan 2021"
"Smalltalk has built-in Linked List, 
here is reventing the wheel."


Object subclass: Node [
  |value next|
  Node class >> value: v next: n [
    <category: 'instance creation'> 
   ^(super new) setValue: v setNext: n
  ]
  value [
    ^value
  ]

  setValue: v setNext: n [
     value := v.
     next := n.
     ^self
  ]

  setValue: v [
     <category: 'basic'> 
     value := v.
     ^self
  ]
  next [
    ^next
  ]
  setNext: n [
    <category: 'basic'> 
    next := n.
    ^next
  ]
  setNextnil [
    next := nil.
  ]
]

Object subclass: SLL [
  |root|
  SLL class >> root: node [
    <category: 'instance creation'>
    ^(super new) setRoot: node
  ]
  root [
     ^root
  ]
  setRoot: node [
    <category: 'basic'>
    root := node.
  ]
  showList [  
    |myNode|
    myNode := root.
    [myNode next isNil not] whileTrue:[
      (myNode value displayString,  ' ' ) print. 
      myNode := myNode next.
    ].
    myNode value printNl.
  ]
]

'We have the list of first 9 primes. Please input a positive integer.' printNl.
n := stdin nextLine.
n := n asInteger.
"n := 5"  "test case"

i := Node value: 23 next: nil.
h := Node value: 19 next: i.
g := Node value: 17 next: h.
f := Node value: 13 next: g.
e := Node value: 11 next: f.
d := Node value:  7 next: e.
c := Node value:  5 next: d.
b := Node value:  3 next: c.
a := Node value:  2 next: b.

abc := SLL root: a.

'Given N' printNl.
n printNl.
'Before trimming operation' printNl.
abc showList.

listSize := 1.

traveller := abc root.
[traveller next isNil not] whileTrue:[
  listSize := listSize + 1.
  traveller := traveller next.
].
listTail := traveller.
m := listSize + 1 - n.
( m < 1 ) ifTrue: [ m := 1 ].

(m > 1) ifTrue: [
  preNode := abc root.
  (m - 2) timesRepeat: [
    preNode := preNode next.
  ].
  nextNode := preNode next next.
  preNode setNext: nextNode.
] ifFalse: [
  abc setRoot: (abc root next).
].

'After trimming operation' printNl.

abc showList.

ObjectMemory quit.

