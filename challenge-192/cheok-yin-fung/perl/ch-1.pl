# The Weekly Challenge 192
# Task 1 Binary Flip
use v5.30.0;

say bf($ARGV[0]) if defined($ARGV[0]);

sub bf {
    my $a = sprintf("%b", $_[0]);
    $a =~ tr/01/10/;
    $a =~ s/^[0]*//;
    return oct("0b$a");
}

use Test::More tests=>3;
ok bf(5) == 2;
ok bf(4) == 3;
ok bf(6) == 1;
