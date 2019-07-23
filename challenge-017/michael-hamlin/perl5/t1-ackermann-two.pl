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
my %limits = (
    5 => 0,
    4 => 2,
);

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
        $result = 1 << $b;  # 2 ** $b
    } elsif ($n == 4) {
        # tetration is iterated exponentiation
        for (2 .. $b) { $result = 1 << $result }    # 2 ** $result
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
    if (defined my $nlimit = $limits{$m}) {
        warn "this may run out of memory..." if $n > $nlimit;
    }
    return _twohyper($m, $n + 3) - 3;
}

unless (@ARGV) {
    _test();
    exit(0);
}
die "must give two nonnegative integers as input" unless @ARGV > 1;

$" = ', ';
my $result = ack2(@ARGV);
my $desc = $result->length < 78 ? $result :
    sprintf 'int with %u digits', length($result);
say "A( @ARGV ) = ", $desc;


sub _test {
    for my $m (0 .. 5) {
        my $nlimit = $limits{$m} // 5;
        for my $n (0 .. $nlimit) {
            my $result = ack2($m, $n);
            my $desc = $result->length < 78 ? $result :
                sprintf 'int with %u digits', length($result);
            say "A( $m, $n ) = ", $desc;
        }
    }
}

