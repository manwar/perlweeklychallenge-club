Solution by James Smith

I'm new to Perl 6 so looking for interesting (not necessarily optimal
solutions) to try out some of the cool features that Perl 6 gives over
Perl 5 - especially as it is basically a new language with new syntactic
sugar....

# Problem 1

This is similar to the problems from last week - but really is actually
simpler - we need to create a signature for each word (use a sorted string
of lower case letters] - and check that against the words in the main
dictionary.

```
perl   perl5/ch-1.pl teams < /usr/share/dict/british-english-insane
```

Now this can be slightly slow - as it is actioning the sort for every set
of letters - we can bypass this if the word has a different number of
letters... (we know it won't match) - so an extra check on length saves us
about 66-75% of the time... [Note as this is an optimized function we complete
the optimization by removing the function call overhead]

```
perl   perl5/ch-1a.pl teams < /usr/share/dict/british-english-insane
```

# Problem 2

Using the same signature function above we create a data structure containing
every key we found with their words, and list those who have the highest
matches. Version 1 looks at just the words containing lower case characters
{but this drops some words that start with a capital letter}.

```
bash run-5.bash
```

Looping through the 4 ubuntu dictionaries...

```
## Small
  7 aeprs        pares parse pears rapes reaps spare spear

Time taken: 0.24 (perl perl5/ch-2.pl /usr/share/dict/british-english-small)

## Large
 10 aeprs        asper pares parse pears prase presa rapes reaps spare spear

Time taken: 0.78 (perl perl5/ch-2.pl /usr/share/dict/british-english-large)

## Huge
 12 aelrst       alerts alters artels lastre rastle ratels salter slater
                 staler stelar talers tarsel
 12 aelst        least leats salet setal slate stale steal stela taels tales
                 teals tesla
 12 aeprs        apers asper pares parse pears prase presa rapes reaps spaer
                 spare spear
 12 aerst        arets aster rates reast resat stare stear strae tares taser
                 tears teras

Time taken: 1.70 (perl perl5/ch-2.pl /usr/share/dict/british-english-huge)

## Insane
 17 aerst        arest arets aster astre earst rates reast resat serta stare
                 stear strae tares tarse taser tears teras

Time taken: 2.91 (perl perl5/ch-2.pl /usr/share/dict/british-english-insane)
```

Due to some quirks in the dictionary - this isn't quite that simple - the above
only includes words without capital letters - if we want to include those
as well we can slighlty modify the code to allow them to be processed... BUT 
we end up with duplicates (with the same word in the dictionary twice once
with an initial capital and once without -- e.g. Taser - taser).

To resolve this - we replace the inner array with a hash keyed on the lower
case version!

```
bash run-5a.bash
```

Obviously more words and slightly more complex so this is slower...

```
## Small
  7 aeprs        pares parse pears rapes reaps spare spear

Loop 1: 0.198171854019165; loop 2: 0.0488781929016113
Time taken: 0.31 (perl perl5/ch-2a.pl /usr/share/dict/british-english-small)

## Large
 10 aelst        least slate Stael stale steal stela taels tales teals tesla
 10 aeprs        asper pares parse pears prase presa rapes reaps spare spear

Loop 1: 0.665744066238403; loop 2: 0.162481784820557
Time taken: 0.95 (perl perl5/ch-2a.pl /usr/share/dict/british-english-large)

## Huge
 13 aeginrst     angriest astringe ganister gantries granites gratines ingrates
                 rangiest reasting stearing Tangiers tasering Tigreans
 13 aelst        least leats salet setal slate Stael stale steal stela taels
                 tales teals tesla

Loop 1: 1.50869011878967; loop 2: 0.36207389831543
Time taken: 2.14 (perl perl5/ch-2a.pl /usr/share/dict/british-english-huge)

## Insane
 18 aerst        arest arets aster astre earst rates reast resat serta stare
                 stear strae tares tarse taser tears teras Tresa

Loop 1: 2.89250707626343; loop 2: 0.623063087463379
Time taken: 4.46 (perl perl5/ch-2a.pl /usr/share/dict/british-english-insane)
```

One issue is the massive grep to find out which ones have the max number of
values... we can avoid this by keeping track of the most common keys....
which leads us to the third solution which keeps track of those keys on the
way through - and so avoids the grep through all keys...

```
bash run-5b.bash
```

```
## Small
  7 aeprs        pares parse pears rapes reaps spare spear

Loop 1: 0.361512899398804; loop 2: 0.00109100341796875
Time taken: 0.40 (perl perl5/ch-2b.pl /usr/share/dict/british-english-small)

## Large
 10 aelst        least slate Stael stale steal stela taels tales teals tesla
 10 aeprs        asper pares parse pears prase presa rapes reaps spare spear

Loop 1: 0.75554895401001; loop 2: 0.00307512283325195
Time taken: 0.88 (perl perl5/ch-2b.pl /usr/share/dict/british-english-large)

## Huge
 13 aeginrst     angriest astringe ganister gantries granites gratines ingrates
                 rangiest reasting stearing Tangiers tasering Tigreans
 13 aelst        least leats salet setal slate Stael stale steal stela taels
                 tales teals tesla

Loop 1: 1.54444408416748; loop 2: 0.00698590278625488
Time taken: 2.03 (perl perl5/ch-2b.pl /usr/share/dict/british-english-huge)

## Insane
 18 aerst        arest arets aster astre earst rates reast resat serta stare
                 stear strae tares tarse taser tears teras Tresa

Loop 1: 2.85167694091797; loop 2: 0.0109820365905762
Time taken: 3.25 (perl perl5/ch-2b.pl /usr/share/dict/british-english-insane)
```

Extra code in first loop adds approx 2-5% extra time in loop; but then reduces
the grep loop to a trivial time...

