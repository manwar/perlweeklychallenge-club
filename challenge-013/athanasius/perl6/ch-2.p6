use v6;

################################################################################
=begin comment

Perl Weekly Challenge 013
=========================

Challenge #2
------------

Write a script to demonstrate *Mutually Recursive* methods. Two methods are
mutually recursive if the first method calls the second and the second calls
first in turn. Using the mutually recursive methods, generate
[ https://en.wikipedia.org/wiki/Hofstadter_sequence#
Hofstadter_Female_and_Male_sequences |Hofstadter Female and Male sequences].

 F ( 0 ) = 1   ;   M ( 0 ) = 0
 F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
 M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.

=end comment

################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use Sub::Memoized;					# Memoization produces an enormous speed-up
									# for even moderately-long series
my Int constant $DEFAULT := 21;

subset Non-negative-integer of Int where * >= 0;
subset Positive-integer     of Int where * >  0;

sub MAIN(Positive-integer:D $length = $DEFAULT)
{
    my Int $n      = $length - 1;        # Convert length to index of final term
    my Str $format = "\n" ~ '%s(%s%d): %s' ~ "\n";
    my Str $prefix = $n == 0 ?? '' !! '0..';
    my     %funcs  = (:&F, :&M);

    $format.printf: $_, $prefix, $n, seq(%funcs{$_}, $n).join(', ') for < F M >;
}

# seq(): Accumulate terms X(0), X(1), .. X(max), where X is either F or M

sub seq(Sub:D $func, Non-negative-integer:D $max --> Array)
{
    my     @series;
    push   @series, $func($_) for 0 .. $max;

    return @series;
}

# F(): Find term n in the "Female" series

sub F(Non-negative-integer:D $n --> Non-negative-integer) is memoized
{
    return $n == 0 ?? 1                         # Base case
                   !! $n - M( F($n - 1) );      # Mutual recursion
}

# M(): Find term n in the "Male" series

sub M(Non-negative-integer:D $n --> Non-negative-integer) is memoized
{
    return $n == 0 ?? 0                         # Base case
                   !! $n - F( M($n - 1) );      # Mutual recursion
}

################################################################################
