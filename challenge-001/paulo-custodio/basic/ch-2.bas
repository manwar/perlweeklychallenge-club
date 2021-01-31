' Challenge 001
'
' Challenge #2
' Write a one-liner to solve the FizzBuzz problem and print the numbers 1
' through 20. However, any number divisible by 3 should be replaced by the word
' ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both
' divisible by 3 and 5 become ‘fizzbuzz’.

dim i as integer

for i=1 to val(command(1))
    if i mod 15=0 then
        print "fizzbuzz"
    elseif i mod  3=0 then
        print "fizz"
    elseif i mod  5=0 then
        print "buzz"
    else
        print trim(str(i))
    end if
next i
