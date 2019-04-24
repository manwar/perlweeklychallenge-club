Solution by James Smith

I'm new to Perl 6 so looking for interesting (not necessarily optimal
solutions) to try out some of the cool features that Perl 6 gives over
Perl 5 - especially as it is basically a new language with new syntactic
sugar....

# Problem 1

This is similar to the problems from last week - but really is actually simpler - we need to
create a signature for each word - and check that against the words in the main dictionary.
```
perl   perl5/ch-1.pl teams < /usr/share/dict/british-english-insane
```

Now this can be slightly slow - as it is actioning the sort for every set of letters - we
can short cut this if the word has a different number of letters... so an extra check saves
us about 66-75% of the time... [ As this is an optimized function we complete the
optimization by removing the function call overhead ]

```
perl   perl5/ch-1a.pl teams < /usr/share/dict/british-english-insane
```

# Problem 2

Using the same signature function above we create a data structure containing every key we
found with their words, and list those who have the highest value...

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
 12 aelrst       alerts alters artels lastre rastle ratels salter slater staler stelar talers tarsel
 12 aelst        least leats salet setal slate stale steal stela taels tales teals tesla
 12 aeprs        apers asper pares parse pears prase presa rapes reaps spaer spare spear
 12 aerst        arets aster rates reast resat stare stear strae tares taser tears teras

Time taken: 1.70 (perl perl5/ch-2.pl /usr/share/dict/british-english-huge)

## Insane
 17 aerst        arest arets aster astre earst rates reast resat serta stare stear strae tares tarse taser tears teras

Time taken: 2.91 (perl perl5/ch-2.pl /usr/share/dict/british-english-insane)
```

Due to some quirks in the dictionary - this isn't quite that simple - the above only includes
words without capital letters - if we want to include those aswell we can slighlty modify the
code to allow them through - but we end up with duplicates - with the same word in twice once
with an initial capital and once without (e.g. Taser - taser). To resolve this - we replace
the inner array with a hash keyed on the lower case version!

```
bash run-5a.bash
```

Obviously more words and slightly more complex so this is slower...

```
## Small
  7 aeprs        pares parse pears rapes reaps spare spear

Time taken: 0.25 (perl perl5/ch-2a.pl /usr/share/dict/british-english-small)

## Large
 10 aelst        least slate Stael stale steal stela taels tales teals tesla
 10 aeprs        asper pares parse pears prase presa rapes reaps spare spear

Time taken: 0.92 (perl perl5/ch-2a.pl /usr/share/dict/british-english-large)

## Huge
 13 aeginrst     angriest astringe ganister gantries granites gratines ingrates rangiest reasting stearing Tangiers tasering Tigreans
 13 aelst        least leats salet setal slate Stael stale steal stela taels tales teals tesla

Time taken: 2.13 (perl perl5/ch-2a.pl /usr/share/dict/british-english-huge)

## Insane
 18 aerst        arest arets aster astre earst rates reast resat serta stare stear strae tares tarse taser tears teras Tresa

Time taken: 4.45 (perl perl5/ch-2a.pl /usr/share/dict/british-english-insane)
```

One issue is the massive grep to find out which ones have the max number of values... we can avoid this by keeping track of the most common keys.... which leads us to the third solution which tracks these on the way through!

```
bash run-5b.bash
```

```
## Small
  7 aeprs        pares parse pears rapes reaps spare spear

Time taken: 0.22 (perl perl5/ch-2b.pl /usr/share/dict/british-english-small)

## Large
 10 aelst        least slate Stael stale steal stela taels tales teals tesla
 10 aeprs        asper pares parse pears prase presa rapes reaps spare spear

Time taken: 0.79 (perl perl5/ch-2b.pl /usr/share/dict/british-english-large)

## Huge
 13 aeginrst     angriest astringe ganister gantries granites gratines ingrates rangiest reasting stearing Tangiers tasering Tigreans
 13 aelst        least leats salet setal slate Stael stale steal stela taels tales teals tesla

Time taken: 1.65 (perl perl5/ch-2b.pl /usr/share/dict/british-english-huge)

## Insane
 18 aerst        arest arets aster astre earst rates reast resat serta stare stear strae tares tarse taser tears teras Tresa

Time taken: 3.12 (perl perl5/ch-2b.pl /usr/share/dict/british-english-insane)
```
