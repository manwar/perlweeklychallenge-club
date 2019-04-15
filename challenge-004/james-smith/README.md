Solution by James Smith

I'm new to Perl 6 so looking for interesting (not necessarily optimal
solutions) to try out some of the cool features that Perl 6 gives over
Perl 5 - especially as it is basically a new language with new syntactic
sugar....

# Problem 1

This is quirky same code between Perl 5 and Perl 6 produce different output - Perl 6 displays one more digit of Pi... so we need to extend the script by one byte (adding ";") to the end of the line...

```
perl -Mfeature=say perl5/ch-1.pl
perl6              perl6/ch-1.p6
```

# Problem 2

## Perl 5

This is a nice problem - I solved this in Perl 5 in two ways - firstly with nested loops - but this requires a label (which is ugly code) to break out of the inner loop and get to the next word. The neater solution requires encapsulating the inner loop inside a function and calling that. Returning true if the word can be matched and false otherwise.

The first part collects together the counts of the letters and the second loops through each of the words to see if there are sufficient letters.

The loop is destructive of the counts array so we pass a copy into the function rather than the usual pass by reference.. This effectively clones the counts array so we don't have to do this explicitly

```
perl perl5/ch-2.pl back < /usr/share/dict/british-english-insane
```

## Perl 6

Similar code to perl 5 - just fixing syntactic sugar. Perl6 though passes by reference (which you have to do explicitly in Perl 5) so you need to clone the counts array before passing it to checkword.

The other change is split - you don't use the empty regex "//" to perform the split - rather the empty string (something frowned upon in Perl5) and to remove the rogue white-space split adds you need to include the additional flag `:skip-empty`

```
perl6 perl6/ch-2.p6 back < /usr/share/dict/british-english-insane
```

