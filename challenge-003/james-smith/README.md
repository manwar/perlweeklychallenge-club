Solution by James Smith

## Problem 2

Wierdly I think problem 2 is the easier this week. I wrote this twice,
the second solution I'm using minimizes memory usage by writing an
iterator which extends the array rather than copying a new one...

The important part is to remember to loop backwards...!

## Problem 1 - Perl 6

I'm new to Perl 6 and so looking for what features of the language
give me an advantage of Perl 5 which I've been programming for over
20 years now...

So I looked at using a generator with lazy evaluation using 
`lazy gather` and `take` to generate the values... Looks interesting
as a "programming construct" but again like last weeks use of
currying - does not particularly look efficient in this case.

I did though like the fact that perl6 does "big int"s much like
python which is good in these challenges as you don't flip to
'e' notation as quickly.


