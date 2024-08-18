# The Weekly Challenge 282
# Task 1 Good Integer
use v5.30.0;
use warnings;

sub gi {
    my $int = $_[0];
    return -1 if $int =~ /(\d)\1\1\1/;
    return $1 x 3 if $int =~ /(\d)\1\1/;
}

use Test::More tests=>3;
ok gi("12344456") eq "444";
ok gi("1233334") eq -1;
ok gi("1020003") eq "000";
