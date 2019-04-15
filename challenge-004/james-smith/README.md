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

For 2a see notes about perl 6 (this is non-destructive...)
```
perl perl5/ch-2.pl back < /usr/share/dict/british-english-insane
perl perl5/ch-2a.pl back < /usr/share/dict/british-english-insane
```

## Perl 6

Because Perl 6 can't pass by value - I've rewritten this to be non-destructive (the checkword function counts up and compares to the main count)... need to check for performance....

The other change is split - you don't use the empty regex "//" to perform the split - rather the empty string (something frowned upon in Perl5) and to remove the rogue white-space split adds you need to include the additional flag `:skip-empty`

I haven't golfed this one entirely - but have used "golf" techniques along the way to make the code in someways more readable using grep rather than if for instance!
```
perl6 perl6/ch-2.p6 back < /usr/share/dict/british-english-insane
```

## Timings

Yet again perl5 out performs perl 6 - perhaps I need to know how to optimize perl 6 code...

```
  perl5    ch-2.pl        1.9 seconds
  perl5    ch-2a.pl       1.3 seconds
  perl6    ch-2.p6       27.1 seconds
```

This time by what looks like a factor of 20.... need a Perl 6 expert to suggest why....

