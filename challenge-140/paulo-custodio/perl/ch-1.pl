#!/usr/bin/perl

# TASK #1 > Add Binary
# Submitted by: Mohammad S Anwar
# You are given two decimal-coded binary numbers, $a and $b.
#
# Write a script to simulate the addition of the given binary numbers.
#
# The script should simulate something like $a + $b. (operator overloading)
#
# Example 1
# Input: $a = 11; $b = 1;
# Output: 100
# Example 2
# Input: $a = 101; $b = 1;
# Output: 110
# Example 3
# Input: $a = 100; $b = 11;
# Output: 111

use Modern::Perl;

{
    package Binary;

    sub new {
        my($class, $n) = @_;
        $n //= 0;
        return bless \$n, $class;
    }

    sub add {
        my($self, $other) = @_;
        my $a = oct("0b".$$self);
        my $b = oct("0b".$$other);
        return ref($self)->new(sprintf("%b", $a+$b));
    }

    use overload '+' => \&add;
    use overload '""' => sub { my($self) = @_; return $$self; }
}

my $a = Binary->new(shift);
my $b = Binary->new(shift);
my $c = $a+$b;
say $c;
