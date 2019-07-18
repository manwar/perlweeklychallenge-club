#! /usr/bin/env perl
#

use 5.22.0;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

# really need the big integers when $m >= 4
# unfortunately the function grows so quickly even this doesnt help a lot
use bigint lib => 'GMP';

my $trace = 0;

# compute 2 ^($n) $b, where ^($n) is the knuth up-arrow notation
# $n is the number of knuth up-arrows, a degree of "hyperness"
# $b is the repetition argument (how many 2's are iterated)
sub _twoknuth( $n, $b ) {
    my $result = 2;
    if ($n == 1) {
        # exponentiation is iterated multiplication
        $result **= $b;
    } elsif ($b == 0) {
        $result = 1;
    } elsif ($b == 1) {
        # result is just 2
    } elsif ($n == 2) {
        # tetration is iterated exponentiation
        for (2 .. $b) { $result = 2 ** $result }
    } else {
        # iterated hyper...
        $result = _twoknuth( $n - 1, 2 );
        if ($b > 2) {
            for (3 .. $b) { $result = _twoknuth( $n - 1, $result ) }
        }
    }
    say "2knuth( $n, $b ) = ", $result if $trace;
    return $result;
}
# the hyper function, H_$n($a, $b), with $a = 2:
sub _twohyper( $n, $b ) {
    my $result = 2;
    if ($n == 0) {
        $result = $b + 1;
    } elsif ($b == 0) {
        # shortcut this?  but never happens in our problem
        $result = $n == 1 ? 2 :
            $n == 2 ? 0 : 1;
    } elsif ($n == 1) {
        $result += $b;
    } elsif ($n == 2) {
        $result *= $b;
    } elsif ($b == 0) {
        $result = 1;
    } elsif ($b == 1) {
        # result is just 2
    } elsif ($n == 3) {
        # exponentiation is iterated multiplication
        $result **= $b;
    } elsif ($n == 4) {
        # tetration is iterated exponentiation
        for (2 .. $b) { $result = 2 ** $result }
    } else {
        # $n > 4 means iterated hyper...
        $result = _twohyper( $n - 1, 2 );
        if ($b > 2) {
            for (3 .. $b) { $result = _twohyper( $n - 1, $result ) }
        }
    }
    say "2hyper( $n, $b ) = ", $result if $trace;
    return $result;
}
sub ack2 ( $m, $n ) {
    die "the function is not defined for negative parameters" if $m < 0 || $n < 0;
    warn "this may run out of memory..." if $m > 4 || $m == 4 && $n >= 3;
    return _twohyper($m, $n + 3) - 3;
}

die "must give two nonnegative integers as input" unless @ARGV > 1;

$" = ', ';
my $result = ack2(@ARGV);
my $desc = $result->length < 78 ? $result :
    sprintf 'int with %u digits', length($result);
say "A( @ARGV ) = ", $desc;


