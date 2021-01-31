"GNU Smalltalk 3.2.5"
"The Weekly Challenge 068 Task 2"
"Reorder List"
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

'Before operation' printNl.
abc showList.

listsize := 1.

traveller := abc root.
[traveller next isNil not] whileTrue:[
  listsize := listsize + 1.
  traveller := traveller next.
].
listTail := traveller.


nodeHandle := abc root.

(listsize - 1 // 2) timesRepeat: [
  traveller := abc root.
  [( traveller next == listTail ) not ] whileTrue: [
    traveller := traveller next.
  ].
  preListTail := traveller.
  
  waiter := nodeHandle next.
  preListTail setNextnil.
  nodeHandle setNextnil.
  guestSeat := listTail.
  nodeHandle setNext: guestSeat.
  listTail := preListTail.
  guestSeat setNext: waiter.  
  
  (nodeHandle next isNil) ifFalse: [
    (nodeHandle next isNil not) ifTrue:
      [nodeHandle := nodeHandle next next.]
  ].
].

'After operation' printNl.

abc showList.

ObjectMemory quit.

