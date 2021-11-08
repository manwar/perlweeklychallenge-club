#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use experimental qw<signatures>;
use List::Util qw<sum0 first>;

# use bigint; # Uncomment for command-line arguments bigger than 309 digits.

# Translation of my O(log N) Raku solution.
sub s2 ( $n ) {
    state $s2 = [ 0, 0, 1 ];
    while ( not defined $s2->[$n] ) {
        my $s = sum0 @{$s2}[-3,-2,-1];
        push @{$s2}, $s - $s2->[-3], $s, $s;
    }
    return $s2->[$n];
}
sub s3 ( $n ) {
    state $s3 = [ s2(0) + s2(1) ];
    while ( not defined $s3->[$n] ) {
        push @{$s3}, $s3->[-1] + s2($#{$s3} + 1);
    }
    return $s3->[$n];
}
sub s123 ( $n ) {
    my $r;
    while ( $n > 0 ) {
        my $k = first { s3($_) > $n } 0..4200; # 4200 is enough for 10**600
        my $pos = $k % 3;

        $r .= $pos + 1; # Digit
        $n -= sum0 map { s2($_) } ($k-$pos) .. $k;
    }
    die "NEGATIVE N: ", $n if $n < 0; # Should be impossible, but I cannot prove it.
    return $r;
}

my @in = @ARGV ? @ARGV : (5,10,60,14410);
say $_, " ==> ", s123($_) for @in;
