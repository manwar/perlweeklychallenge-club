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

We don't actually need to recurse here, we know that we can combine
the strings into 2 or more circles (in many different ways potentially).
But if we have two circles that touch - it is is easy to see that by 
splicing the two circles together at this point makes a single large
circle...

So here comes solution 2....

Find a loop, if we have any words left - see if any of those words start
with a letter we have already seen in the loop. If so we repeat the
loop finder with the rest of the words... Probably easier to see in 
pictures:

```
abc

cde  ->   a-b-c    ->  a-b-c        ->  a b c
          |   |        |   |            |   |
efg       h   d        h   d            h   d
          |   |        |   |            |   |
gha       g-f-e        g-f-e-o-p        g   e-o-p
                           |  /         |      /
eop       e-o-p            t q          f     q
          |  /             |/           |    /
pqz       t q              z            e-t-z
          |/
zte       z 
```

So the non-recursive routine is:
```perl
sub circ_single_non_recursive {
  ## This quickly filters out those cases in which we
  ## can't join end on end
  my @words = @_;
  my %F;
  ($F{substr$_,0,1}++,$F{substr$_,-1}--) foreach @words;
  return 0 if grep {$_} values %F; 

  ## Now we start at any point and get the first circle, keeping
  ## track of letters we have included in the loop(s) `%seen`
  my %seen;
  while(@words) {
    my $init = shift @words;
    $seen{ord $init}=1;
    my $ptr = 0;
    ## Skip this bit if the word is "self-closing" ie starts/ends
    ## with same letter...
    if( substr($init,0,1) ne substr $init, -1 ) {
      while($ptr++ < @words) {
        ## If we have a match - we just start again until
        ## we do not find a match....
        if( (substr $init,-1) eq substr $words[0],0,1 ) {
          $seen{ ord $words[0] } = 1;
          $init =shift @words;
          $ptr = 0;
          return 1 unless @words; ## Return 1 we have got to end of list!
        }
        ## Rotate the list.
        push @words, shift @words;
      }
    }
    return 1 unless @words; ## We have no words left - success...
    ## Do we have a loop that will extend the first loop...
    ## Find any word which starts with a letter we have already seen!
    $ptr=0;
    $init=undef;
    while( $ptr++ < @words) {
      if($seen{ord $words[0]}) {
        $init=1;
        last;
      }
      push @words,shift@words;
    }
    return 0 unless $init; ## No words - so will return 0
  }
  return 1; ## Got to the end - no words left! YAY!!!
}
```
## Summary

Looking at performance - avoiding recursion is good and increases
performance considerably. For small examples it is 5-20% faster, but
for more complex examples the benefit grows rapidly.

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