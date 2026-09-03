#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: Prefix and Suffix
# Count pairs (i, j) with i < j where array[i] is both prefix and suffix of array[j].

sub count_prefix_suffix_pairs (@array) {
    my $count = 0;
    my $n     = scalar @array;

    for my $i ( 0 .. $n - 2 ) {
        my $s1  = $array[$i];
        my $len = length($s1);

        for my $j ( $i + 1 .. $n - 1 ) {
            my $s2 = $array[$j];
            next if length($s2) < $len;

            if ( substr( $s2, 0, $len ) eq $s1 && substr( $s2, -$len ) eq $s1 ) {
                $count++;
            }
        }
    }

    return $count;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( count_prefix_suffix_pairs( "a", "aba", "ababa", "aa" ), 4, 'Example 1' );
    is( count_prefix_suffix_pairs( "pa", "papa", "ma", "mama" ), 2, 'Example 2' );
    is( count_prefix_suffix_pairs( "abao", "ab" ), 0, 'Example 3' );
    is( count_prefix_suffix_pairs( "abab", "abab" ), 1, 'Example 4' );
    is( count_prefix_suffix_pairs( "ab", "abab", "ababab" ), 3, 'Example 5' );
    is( count_prefix_suffix_pairs( "abc", "def", "ghij" ), 0, 'Example 6' );

    done_testing();
}
else {
    say count_prefix_suffix_pairs(@ARGV);
}
