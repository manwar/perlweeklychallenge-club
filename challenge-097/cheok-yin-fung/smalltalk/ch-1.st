"GNU Smalltalk 3.2.5"
"The Weekly Challenge 097 Task 1"
"Usage: gst -S ch-1.st"

'String going to be encrypted: ' printNl.
myS := stdin nextLine.
"myS := 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG'." "Test case"
myS asUppercase.
'Left Shift Value: ' printNl.
myN := stdin nextLine.
myN := myN asInteger.
"myN := 3." "Test case"

myArr := String new: myS size.

1 to: myS size do:
  [:index|
    ((myS at: index) asciiValue ~= 32) ifTrue: [
      temp := ((( (myS at: index) asciiValue - 65 - myN ) \\ 26 ) + 65).
      myArr at: index put: (Character value: temp).
    ] ifFalse: [myArr at: index put: (Character value: 32).]
  ].

myArr printNl.

ObjectMemory quit.
