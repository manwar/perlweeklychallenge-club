#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ fc postderef say signatures state switch unicode_strings };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

my $i = $ARGV[0];
$i //= 49;
$i += 0;    # force error if $i is non-numeric

my $n = 2**$i;
my $e = find_euler($n);

say <<"END";
    i = $i
    n = $n
    e = $e

END
exit;

sub find_euler ( $n ) {
    return ( ( 1 + ( 1 / $n ) )**$n );
}

