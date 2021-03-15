"GNU Smalltalk 3.2.5"
"The Weekly Challenge 096 Task 1 Palindrome Number"
"Usage: gst -S ch-1.st"
"written on 27th Jan 2021"

myN := stdin nextLine.
(myN reverse = myN) ifTrue: ['1' printNl.] 
                    ifFalse: ['0' printNl.].

ObjectMemory quit.
