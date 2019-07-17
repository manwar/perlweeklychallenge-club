#! /usr/bin/env perl
#

use 5.22.0;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
use integer;

# really need the big integers when $m >= 4
# use bigint lib => 'GMP';

no warnings 'recursion';

my $count = 0;

sub _ack( $m, $n ) {
    $count++;
    if ($m > 0) {
        return _ack( $m - 1, 1 ) unless $n;
        return _ack( $m - 1, _ack( $m, $n - 1));
    } else {
        return $n + 1;
    }
}
sub ack ( $m, $n ) {
    die "the function is not defined for negative parameters" if $m < 0 || $n < 0;
    return _ack($m, $n);
}

die "must give two nonnegative integers as input" unless @ARGV > 1;

$" = ', ';
say "A( @ARGV ) = ", ack(@ARGV), "  ...after $count calls.";

