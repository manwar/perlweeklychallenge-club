#!/usr/bin/perl -s

use v5.16;
use warnings;
use Math::Prime::Util 'lucasu';

die <<EOS unless @ARGV;
usage: $0 N

N
    Count the different ways to climb a stair of N steps taking either
    one ore two steps at a time.

EOS

# Are Abigail and Abigail the same person?  See perlsecret.
<<m=~m>>
Let S(n) be the number of different ways to climb a stair of n steps
taking either one ore two steps at a time.

Let n > 2.  The last move is either one step with S(n-1) ways to reach
the second last step or two steps with S(n-2) ways to reach the step
before it.

Thus S(n) = S(n-1) + S(n-2).  Furthermore, the trivial cases S(1) = 1
and S(2) = 2 lead to S(n) = Fₙ₊₁, the (n+1)th Fibonacci number.

The Fibonacci sequence Fₙ is the particular Lucas sequence Uₙ(1, -1) as
provided by Math::Prime::Util.

See e.g. http://oeis.org/wiki/Lucas_sequences.

m
;

say lucasu 1, -1, 1 + shift;
