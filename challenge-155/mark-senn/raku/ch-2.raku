# Use Raku version 6.d.
use v6.d;

# Find the period of the 3rd Pisano period.
my $modulo = 3;

# Define a Fibonacci series (called sequence in Raku).
# The last number in the series is the first number greater than 10,000.
my $fibonacci := 0, 1, -> $a, $b {$a + $b} ... -> $a {$a > 10_000};

# Compute the Fibonacci series modulo $modulo.
my @modulo = $fibonacci >>%>> $modulo;

# Find the period.
# Test periods from 2 to whatever.
for (2..*) -> $period
{
    # Divide @modulo into groups of period using ".rotor($period)"---groups
    # with fewer than period elements are ignored.
    # See
    # https://docs.raku.org/language/operators#infix_eqv
    # for information about "eqv".
    # "[eqv] (1,2,3,4)" is equivalent to "1 eqv 2 eqv 3 eqv 4".
    # "[eqv] ((1,2), (3,4))" is equivalent to "(1,2) eqv (3,4)".
    # If all groups are equal that is the period.

    [eqv] @modulo.rotor($period) and $period.say, last;
}2
