[< Previous 153](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-153/james-smith) |
[Next 155 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-155/james-smith)
# The Weekly Challenge #154 - `do` and `redo` there is no `try`!

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-154/james-smith

# Challenge 1 - Missing Permutation

***You are given possible permutations of the string 'PERL'. Find any missing ones***

## Solution 1 - answering the question - not the input data!

The input is a special case of the data where there is only one missing solution. We will show
in solution 2 how this can be "solved" with much smaller code!

For solving for the general case we need to work through all the permutations and see if they
are not present in our list. To do the check we start by using the classic Perl solution of making
the words the keys of a hash!

For the permutations, we create an array of the letters in the words in alphabetic order in this
case `('E','L','P','R')`, and each stage we rearrange the letters so they are next in alphabetic
order `('E','L','P','R')` to `('E','L','R','P')` to `('E','P','L','R')` ... `('R','P','L','E')`

The code to do this is.
```perl
sub next_perm {
  my( $i, $j );
  ( $s[$_] lt $s[$_+1] ) && ( $i = $_ ) for 0    .. @s-2;
  return unless defined $i;
  ( $s[$i] lt $s[$_  ] ) && ( $j = $_ ) for $i+1 .. @s-1;
  @s[ $i, $j       ] = @s[ $j, $i               ];
  @s[ $i+1 .. @s-1 ] = @s[ reverse $i+1 .. @s-1 ];
  return join '',@s;
}
```

This was written up for a previous challenge. It avoids having to use a recursive call. Due to
the way the code is written it automatically removes duplicates.

The overall code then reduces to:

```perl
my $w = join '', @s = sort split //, 'PERL';                   ## set up initial word
my %check = map { $_=>1 } @words;                              ## create look up
do { exists $check{$w} || say "  * $w" } while $w = next_perm; ## loop until complete
```

We have to use `do { } while` rather than `while() { }` so that
we execute the functions in the loop BEFORE the check, otherwise
we miss the first order "`ELPR`".

## Solution 2 - if we know there is only 1 missing permutation and all words in the list are unique!!

```perl
my $r ='';
$r^=$_ for @words;
say $r;
```

This works by bit flipping each of the words in the list of permutations. For each letter - if flipped
twice it returns to the null `\0` character - so if flipped an odd number of times is the letter itself.
We note that in the permutation list - for the 23 combinations, each character is flipped 6 times in
each location EXCEPT for the characters of the missing word (where it will be 5)...!

# Challange 2 - Padovan Prime

***A Padovan Prime is a Padovan Number that’s also prime. The Padovan sequence is the sequence of integers P(n) defined by the initial values: P(0) = P(1) = P(2) = 1 and then the relationship P(n) = P(n-2) + P(n-3). Find the first 10 distinct solutions.***

## The solution

By using `is_prime` from the `Math::Prime::Util` we can quickly check to see if a number is prime. We then have to generate the Padovan sequence. We can generate the whole sequence - but that isn't needed for this problem we only need the values to create the next number, if we define these as `p, q, r` we note that to get the next one in the sequence we can define `(p',q',r') = (q,r,p+q);`

```perl
my$p=my$q=my$r=1;
($p,$q,$r)=($q,$r,$p+$q),$r!=$q&&is_prime($r)?say$r:redo for 1..10;
```

Expanding this out gives..

```perl
$p=$q=$r=1;

for (1..10) {
  ( $p, $q, $r ) = ( $q, $r, $p+$q );
  redo if     $r == $q;       ## skip (redo loop) if same as previous value
  redo unless is_prime($r);   ## skip (redo loop) if not prime
  say $r;                     ## output if we get here!
}
```

Note we use a *little used* perl construct - `redo` which restarts the loop without incrementing the counter. So in this case finds the next padovan number without incrementing the counter in the outside loop. So to find 10 answers, we just loop from 1 to 10.
