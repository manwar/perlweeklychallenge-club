Solution by James Smith

I'm new to Perl 6 so looking for interesting (not necessarily optimal
solutions) to try out some of the cool features that Perl 6 gives over
Perl 5 - especially as it is basically a new language with new syntactic
sugar....

# Problem 2

Wierdly I think problem 2 is the easier one this week.

I wrote this twice, the second solution I'm using minimizes memory
usage by extends the array rather than copying a new one. We just
loop through the array adding the next value to the current one
and then unshift the first 1 to the array.

Can't see an easy neat way of doing it differently in Perl 5 and 6 -
but I do like

1. the MAIN function in perl which clears up how CLI
parameters are pulled into the code and

1. the arbitrary precision
integers... (no more "e+" notation)

# Problem 1

## Perl 5

This was an interesting challenge - and still working out if I have
the optimal solution, again I'll write an iterator which gets the
next number and call this multiple times to get the list....

To find the next one we have to find the first number larger than the
current largest number in the list - which is a multiple of 5, 3 or 2
of an entry already in the list...

The loop we use is interesting as it contains `next`, `last` and `redo`
commands. Firstly how it works - we are looking for numbers whose
multiples are larger than the largest value.

* so we start looping through the list looking for multiples of 5 (we
will get to a larger value first when multiplying by 5). We use `next`
here to short cut the loop until we have reached a larger value...

* we then store this, and then continue with the next highest factor.

  * If there are no factors left we use `last` to exit the loop and
  and "add" the value to the hamming array.
  
  * If there are factors left we need to continue the loop with the
  new value - BUT - we need to re-check the current element from the
  hamming array. We do this with `redo` which repeats the loop with
  the same value...

* once we have a new value we store it on the array and return it...

This method means we only loop through less than once rather than
looping through for 2, 3 & 5....

## Perl 6

I'm new to Perl 6 and so looking for what features of the language
give me an advantage of Perl 5 which I've been programming for over
20 years now...

So I looked at using a generator with lazy evaluation using 
`lazy gather` and `take` to generate the values... Looks interesting
as a "programming construct" but again like last weeks use of
currying - does not particularly look efficient in this case.




