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
    state @known;
    $count++;
    return $known[$m][$n] ||= do {
        !$m ? $n + 1 :
        !$n ? _ack($m - 1, 1) :
        _ack($m - 1, _ack($m, $n - 1));
    };
}
sub ack ( $m, $n ) {
    die "the function is not defined for negative parameters" if $m < 0 || $n < 0;
    return _ack($m, $n);
}

die "must give two nonnegative integers as input" unless @ARGV > 1;

$" = ', ';
say "A( @ARGV ) = ", ack(@ARGV), "  ...after $count calls.";

