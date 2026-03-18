' Perl Weekly Challenge 001 - Task 2 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

dim i as integer

for i=1 to val(command(1))
    if i mod 15=0 then
        print "fizzbuzz"
    elseif i mod  3=0 then
        print "fizz"
    elseif i mod  5=0 then
        print "buzz"
    else
        print i
    end if
next i
