#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ sum };

use constant COUNT => 5;

sub is_perfect {
    my ($n) = @_;
    my @divisors = grep 0 == $n % $_, 1 .. $n - 1;
    return sum(@divisors) == $n
}

my $n = 2;
my $so_far = 0;
while ($so_far < COUNT) {
    ++$so_far, say $n if is_perfect($n);
    ++$n
}
