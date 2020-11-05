#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;
use 5.028;
use feature qw(signatures);
no warnings 'experimental::signatures';
use Scalar::Util 'looks_like_number';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

my @nums = @ARGV;

if ( @nums == 0 or ( grep { !looks_like_number($_) or $_ < 0 } @nums ) ) {
    die "Was expecting a list of positive numbers";
}

say check_for_subset_between_limits( 1, 2, @nums );

sub check_for_subset_between_limits ( $min, $max, @nums ) {
    return if int @nums == 0;
    return if 3 > int @nums;
    return if !looks_like_number($min);
    return if !looks_like_number($max);
    return if ( $min > $max );
    return if ( $max < 0 );
    my $arr_len = int @nums;
    for my $i ( 0 .. $arr_len - 3 ) {
        next if ( $nums[$i] > $max );
        my $m2 = $max - $nums[$i];
        for my $j ( $i + 1 .. $arr_len - 2 ) {
            next if $nums[$j] > $m2;
            my $m3 = $m2 - $nums[$j];
            for my $k ( $j + 2 .. $arr_len - 1 ) {
                next if $nums[$k] > $m3;
                next if $nums[$i] + $nums[$j] + $nums[$k] < $min;
                say "($i,$j,$k)";
                return 1;
            }
        }
    }
}

