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

The list of words are:
```
1: a, i, m, x
2: ad, ah, am, an, as, at, ax, be, by, cc, cs, do, eh, em, go, hi, ho, ii, in, is, it,
   iv, ix, ms, mu, my, no, or, ox, qt, xx
3: ace, act, add, ado, ads, ago, ail, aim, air, all, amp, ant, any, apt, art, ass, bee,
   beg, bet, bin, bit, boo, bop, bow, box, boy, buy, chi, coo, cop, cot, cow, cox, coy,
   cry, den, dew, dim, din, dip, dos, dot, dry, eel, egg, ego, elm, err, fin, fir, fit,
   fix, flu, fly, for, fox, fry, gin, gnu, goo, got, guy, him, hip, his, hit, hop, hot,
   how, iii, ill, imp, inn, ins, ivy, jot, joy, lop, lot, low, moo, mop, mow, nor, not,
   now, opt, pry, xxx
4: abet, ably, aces, adds, ahoy, ails, aims, airs, airy, ally, alms, amps, beef, been,
   beer, bees, beet, begs, bell, belt, bent, best, bill, bins, blot, blow, boor, boos,
   boot, boss, buzz, cell, cent, chin, chip, chop, chow, city, clot, coop, coos, cops,
   copy, cost, crux, deem, deep, deer, deft, defy, dens, dent, deny, dill, dims, dins,
   dips, dirt, door, eels, eggs, egos, elms, envy, errs, fill, film, fins, firs, fist,
   fizz, flop, flow, flux, foot, fort, foxy, fuzz, gill, gilt, gins, gist, glow, gory,
   hill, hilt, hims, hint, hips, hiss, hoop, hoot, hops, host, ills, imps, inns, knot,
   know, loop, loot, lops, loss, lost, moor, moos, moot, mops, moss, most, nosy
5: abbey, abbot, abhor, abort, adept, adopt, affix, afoot, aglow, allot, allow, alloy,
   annoy, beefs, beefy, beers, befit, begin, bells, belly, below, berry, bills, boors,
   boost, booty, bossy, cello, cells, chill, chimp, chins, chips, chops, coops, deems,
   deeps, deity, dills, dirty, ditty, doors, empty, fills, filly, films, filmy, first,
   floor, flops, floss, forty, ghost, gills, glory, gloss, hills, hilly, hippy, hoops,
   loops, lorry, moors, mossy
6: abhors, accent, accept, access, accost, almost, begins, bellow, billow, cellos,
   chills, chilly, chimps, chintz, choosy, choppy, effort, floors, floppy, glossy,
   knotty
```

# Challenge 2 - Pangrams

***A pangram is a sentence or phrase that uses every letter in the English alphabet at least once. For example, perhaps the most well known pangram is: "the quick brown fox jumps over the lazy dog"***.

```perl
sub generate_a_pangram_random {
  my ($list,$c,%letters,@pangram) = (shift,0,map { $_ => 0 } 'a'..'z');
  O: while( $c < 26 ) {            ## Keep a counter of letters used...
    my($f,@l) = (1,split //, my $word = $list->[rand @{$list}]);
    $f *= $letters{$_} foreach @l;
    next if $f;                    ## Only choose words which have at least one new unique letter
    push @pangram, $word;
    $letters{$_} || ( $letters{$_}=1, $c++ ) for @l;
  }
  @pangram;
}
```

## Bonus challenge #1 *"cabbed fad high jackal moping ventriloquist waxy fez"*

I set myself the following challenge: choose a pangram where - for each word we add we can only add the
next consecutive letters in the alphabet. *e.g.*
  * the first word could be `cab` as it contains `a`, `b`, and `c`;
  * the second word could be `bead` as it contains `e` and `d`.
We then look for the shortest word which introduces the most letters.

```
sub generate_a_pangram_alpha_order {
  my ($list,$next,%letters,@pangram) = (shift,'a',map { $_ => 0 } 'a'..'z');
  O: until( 'aa' eq $next ) { ## If we get to "aa" we know that we have finished
    my($best,$best_length,$best_word) = (0,0,'');
    W: foreach my $word ( @{$list} ) {
      my %t = map { $_=>1 } split //, $word;
      my ($score,$ch) = (0,$next);
      ($_ gt $ch) ? next W : ($score++,$ch++) for sort grep { $_ ge $next } keys %t;
            ## Get a list of letters in alphabetical order which are greater that the ones
            ## we already have in the pangram, and find out how many we have that are
            ## consecutive as $next. If they aren't all consecutive or start with $next
            ## we jump out of the loop and look at the next word
      next if $score < $best;
      if( $score > $best ) {
        ($best,$best_word,$best_length) = ($score,$word,length $word);
            ## Update best word {and reset associated "metadata")
      } elsif( $best_length > length $word ) {
        ($best_word,$best_length) = ($word,length $word);
            ## score is equal to best update if shorter word
      }
    }
    push @pangram, $best_word;
    $next++ foreach 1..$best;         ## Find next letter to add
  }
  @pangram;
}
```

### The solution *"cabbed fad high jackal moping ventriloquist waxy fez"*

I like that the solution contains very few words - and a total of only 45 characters - the star being *ventriloquist*:

 | Word          | Extra letters | Letters |
 | ------------- | ------------- | ------: |
 | cabbed        | 5 - *abcde*   |       6 |
 | fad           | 1 - *f*       |       3 |
 | high          | 3 - *ghi*     |       4 |
 | jackal        | 3 - *jkl*     |       6 |
 | moping        | 4 - *mnop*    |       6 |
 | ventriloquist | 6 - *qrstuv*  |      13 |
 | waxy          | 3 - *wxy*     |       4 | 
 | fez           | 1 - *fez*     |       3 |
 | TOTAL         |               |      45 |
 
***Note:** This isn't the shortest pangram - e.g. you can replace **cabbed fad** with **cab fed** to reduce the length to 42 characters. **cab fed  high jackal moping ventriloquist waxy fez**.*
 
## Bonus challenge #2 *"a baa cc ad be fad age ah i jab eke ail m an do pa qi or as at mu iv we x by fez"*

***Note:** to achieve this we have added 3 words to the dictionary "baa", "i" and "qi" which give a solution*

This is a pangram which a word which includes the same letter as previous words plus the next letter in the alphabet. This is similar (but slightly simplified) version of the previous one:

```perl
sub generate_one_letter_at_time {
  my ($list,$next,%letters,@pangram) = (shift,'a',map { $_ => 0 } 'a'..'z');
  O: until( 'aa' eq $next ) {
    my($best,$best_length,$best_word) = (0,1e6,'');
    W: foreach my $word ( @{$list} ) {
      my %t = map { $_=>1 } split //, $word;
      my @T = grep { $_ ge $next } keys %t;
      ($best_word,$best_length) = ($word,length $word) if @T == 1 && $T[0] eq $next && $best_length > length $word;
    }
    push @pangram, $best_word;
    $next++;
  }
  @pangram;
}
```

If we change the inequality from "`>`" to "`<`" in the inner loop we get the longest word that can be made with only adding that letter - then we get the following:

***a baa cab add acceded defaced baggage beheaded caddied jabbed feedback blackjacked blackmailed blackjacking blindfolding handicapping qi archaeological incomprehensible misrepresentations telecommunications oversimplification counterclockwise extraterrestrials characteristically institutionalizing***

## Bonus challenge #3 *"oversimplification ladybug hawk jazz equinox"*

A different one now - choose the sentance by finding a word that is as short as possible but contains as many different letters as possible, and repeat for all 26 letters....

```perl
sub most_letters {
  my ($list,$c,%letters,@pangram) = (shift,0,map{$_=>1}'a'..'z');
  while($c<26) {
    my( $most, $length, $best )=(0,1000,'');
    I: foreach my $word (@{$list}) {
      my %t = map { $_ => 1 } grep { $letters{$_} } split //, $word;
      if( $most < scalar keys %t ) {
        ($length,$best,$most) = (length $word,$word,scalar keys %t);
      } elsif( scalar keys %t == $most && $length > length $word ) {
        $length = length ($best=$word);
      }
    }
    $c+=$most;
    $letters{$_}=0 foreach split//,$best;
    push @pangram, $best;
  }
  @pangram;
}
```

This gives us *"**oversimpl**i**f**i**cat**io**n** la**dybug** **h**a**wk** **j**a**z**z e**q**uino**x**"*

If we replace "equinox" with "quixotic" which introduces the same two letters "q" and "x" you could rearrange this to: **Ladybug Hawk - Quixotic jazz oversimplification**. This just sounds like an NME headline!

If we stick to the words from challenge 1 - we get *"abhors deity flux know chimp go iv qt jot buzz"*.
