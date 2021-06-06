# Perl Weekly Challenge #115

# Cursing at recursion

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-115/james-smith/perl

# Challenge 1 - String Chain

***You are given an array of strings. Write a script to find out if the given strings can be chained to form a circle. Print 1 if found otherwise 0.***

## Clarification

Here we make the assumption that the chain includes **ALL** elements.

## The solution - a quick filter

There is a trick to see if we have **NO** solution. If we keep a track
of all the times a letter appears at the beginning of the word AND at
the end then these have to be equal! We can do this in perl using a hash,
for initial letters we increment the value of the hash, for final letters
we decrement it.

If any value in the hash at the end of the loop is non-zero then we have
an imbalance and so we can't find a solution.

```perl
  my %F;
  ($F{substr$_,0,1}++,$F{substr$_,-1}--) foreach @words;
  return 0 if grep {$_} values %F;
```

If this check is passed we may still not have a solution as we may have
two or more circles. e.g.

```
 abc           a->b->c    m->n->o
 cde           ^     |    ^     |
 efg           |     v    |     v
 gha           h     d    t     p
 mno           ^     |    ^     |
 opq           |     v    |     v
 qrs           g<-f<-e    s<-r<-q
 stm
```
## The curse of recursion.

We can use recursion to find out if we have ANY solution which
satisfies this criteria.

```perl
sub exhaust {
  my ($init,@words) = @_;
  my $n = @words;
  if( $n==1) {
    return substr($init,-1)  eq substr($words[0],0,1)
        && substr($init,0,1) eq substr($words[0],-1)  ? 1 : 0;
  }
  foreach(1..$n) {
    push @words,shift @words;
    next unless (substr $init,-1) eq substr $words[0],0,1;
    return 1 if exhaust( $init.$words[0], @words[1..($n-1)] );
  }
  return 0;
}
```

We rotate the words array to avoid needing to do a complex `splice`...

This works - but for complex examples can hit the dreaded
"Deep recursion" warning...

## The cure for recursion...

It turns out we don't have to do this recursive search. Instead
we can use a simple loop to propogate our search from a starting
word.

We create a "tree" structure where each letter "node" is connected
to another "node"... We get a hash of hashes.

We choose one starting "word" and see which words we can attach
to the end to get the "2nd level" of letters, and repeate.

This loop boils down to 2 operations:

 * Remove elements from the graph that we have processed
 * Check elements we have just found...

We repeat until we no-longer remove elements.

If we have removed all the elements we do have a single loop, otherwise
it will be connected.
   
```perl
sub circ_single_connected_nc {
  my( %F, %ends );

  ( $F{ substr $_, 0, 1 }++, $F{    substr $_, -1   }-- ) foreach @_;
  return 0 if grep {$_} values %F;

  $ends{ substr $_, 0, 1 }{ substr $_, -1 }=1 foreach @_;
  my @seeds = [keys %ends]->[0];
  while(@seeds) {
    my %x   = map { $_ => 1 }
              map { keys %{ delete $ends{$_} } }
              @seeds;
    @seeds  = grep { exists $ends{$_} } keys %x;
  }
  return keys %ends ? 0 : 1;
}
```
## Summary

Looking at performance - avoiding recursion is good and increases
performance considerably. For simple examples there is a slight
gain but as the "graph" gets more complex then the performance
improves dramatically.

# Challenge 2 - Largest even

***You are given a list of positive integers (`0`-`9`), single digit. Write a script to find the largest multiple of `2` that can be formed from the list.***

## The solution

For once challenge 2 is easier.

To find the largest number we just sort the digits in descending order
and stitch them together.

To find the largest even number we just sort the digits in descending
order, but move the lowest even number to the end.

```perl
sub biggest_even {
  my $ptr = my @digits = reverse sort @{$_[0]};
  while( $ptr-- ) {
    next if $digits[$ptr] & 1; ## Skip if odd...
    return join '',
      @digits[ 0..$ptr-1, $ptr+1..$#digits, $ptr ];
  }
  return '';
}
```

The while loop just looks for the smallest even number & moves it
to the end using an array slice.
