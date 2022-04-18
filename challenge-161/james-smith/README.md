[< Previous 160](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-160/james-smith) |
[Next 162 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-162/james-smith)
# The Weekly Challenge 161

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-161/james-smith

# Challenge 1 - Abecedarian Words

***An abecedarian word is a word whose letters are arranged in alphabetical order. For example, “knotty” is an abecedarian word, but “knots” is not. Output or return a list of all abecedarian words in the dictionary, sorted in decreasing order of length. Optionally, using only abecedarian words, leave a short comment in your code to make your reviewer smile.***

## The solution


```perl
open my $d, q(<), 'dictionary.txt';

my @abcde;

O: while( my $f='', chomp(my $w =<$d>) ) {
  $f gt $_ ? (next O) : ($f=$_) for split //, $w;
  push @abcde, $w;
}

$a=$_, say "$a: ", join q(, ), grep { $a == length $_ } @abcde for 1..6;
```

```
1: a, i, m, x
2: ad, ah, am, an, as, at, ax, be, by, cc, cs, do, eh, em, go, hi, ho, ii, in, is, it, iv, ix, ms, mu, my, no, or, ox, qt, xx
3: ace, act, add, ado, ads, ago, ail, aim, air, all, amp, ant, any, apt, art, ass, bee, beg, bet, bin, bit, boo, bop, bow, box, boy, buy, chi, coo, cop, cot, cow, cox, coy, cry, den, dew, dim, din, dip, dos, dot, dry, eel, egg, ego, elm, err, fin, fir, fit, fix, flu, fly, for, fox, fry, gin, gnu, goo, got, guy, him, hip, his, hit, hop, hot, how, iii, ill, imp, inn, ins, ivy, jot, joy, lop, lot, low, moo, mop, mow, nor, not, now, opt, pry, xxx
4: abet, ably, aces, adds, ahoy, ails, aims, airs, airy, ally, alms, amps, beef, been, beer, bees, beet, begs, bell, belt, bent, best, bill, bins, blot, blow, boor, boos, boot, boss, buzz, cell, cent, chin, chip, chop, chow, city, clot, coop, coos, cops, copy, cost, crux, deem, deep, deer, deft, defy, dens, dent, deny, dill, dims, dins, dips, dirt, door, eels, eggs, egos, elms, envy, errs, fill, film, fins, firs, fist, fizz, flop, flow, flux, foot, fort, foxy, fuzz, gill, gilt, gins, gist, glow, gory, hill, hilt, hims, hint, hips, hiss, hoop, hoot, hops, host, ills, imps, inns, knot, know, loop, loot, lops, loss, lost, moor, moos, moot, mops, moss, most, nosy
5: abbey, abbot, abhor, abort, adept, adopt, affix, afoot, aglow, allot, allow, alloy, annoy, beefs, beefy, beers, befit, begin, bells, belly, below, berry, bills, boors, boost, booty, bossy, cello, cells, chill, chimp, chins, chips, chops, coops, deems, deeps, deity, dills, dirty, ditty, doors, empty, fills, filly, films, filmy, first, floor, flops, floss, forty, ghost, gills, glory, gloss, hills, hilly, hippy, hoops, loops, lorry, moors, mossy
6: abhors, accent, accept, access, accost, almost, begins, bellow, billow, cellos, chills, chilly, chimps, chintz, choosy, choppy, effort, floors, floppy, glossy, knotty
```

# Challenge 2 - Pangrams

***A pangram is a sentence or phrase that uses every letter in the English alphabet at least once. For example, perhaps the most well known pangram is: "the quick brown fox jumps over the lazy dog"***.

```perl
sub generate_a_pangram_random {
  my ($list,$c,%letters,@pangram) = (shift,0,map { $_ => 0 } 'a'..'z');
  O: while( $c < 26 ) {
    my($f,@l) = (1,split //, my $word = $list->[rand @{$list}]);
    $f *= $letters{$_} foreach @l;
    next if $f;
    push @pangram, $word;
    $letters{$_} || ( $letters{$_}=1, $c++ ) for @l;
  }
  @pangram;
}
```

## Bonus challenge

```cabbed fad high jackal moping ventriloquist waxy fez```

