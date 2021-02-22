"GNU Smalltalk 3.2.5"
"The Weekly Challenge 096 Task 1"
"Reverse Words"
"Usage: gst -S ch-1.st"
"written on 27th Jan 2021"

'String going to be modified: ' printNl.
s := stdin nextLine.


"s := 'The Weekly Challenge'."
parts := s substrings.
parts := parts reverse. 

t := parts first.
parts := parts allButFirst.
parts do: [:each | t := (t,' ',each) ].

t printNl.

ObjectMemory quit.
