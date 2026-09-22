#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use List::Util qw(max);

# Task 2: Maximum Product of Word Lengths
# Return maximum len($words[i]) * len($words[j]) where the two words do not share common letters.
# If no such two words exist, return 0.

sub max_product (@words) {
    return 0 if @words < 2;

    # Map each word to a bitmask of its lowercase characters
    my @masks;
    my @lengths;

    for my $w (@words) {
        my $mask = 0;
        for my $char ( split //, lc($w) ) {
            $mask |= ( 1 << ( ord($char) - ord('a') ) );
        }
        push @masks,   $mask;
        push @lengths, length($w);
    }

    my $max_prod = 0;
    my $n        = scalar @words;

    for my $i ( 0 .. $n - 2 ) {
        for my $j ( $i + 1 .. $n - 1 ) {
            # Two words share no common letters if bitwise AND is 0
            if ( ( $masks[$i] & $masks[$j] ) == 0 ) {
                my $prod = $lengths[$i] * $lengths[$j];
                $max_prod = $prod if $prod > $max_prod;
            }
        }
    }

    return $max_prod;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( max_product( "a", "ab", "abc", "d", "de", "def" ), 9,  'Example 1' );
    is( max_product( "a", "aa", "aaa", "aaaa" ),           0,  'Example 2' );
    is( max_product( "meet", "app", "code", "sky", "bold" ), 16, 'Example 3' );
    is( max_product( "a", "ab", "abc", "abcd", "efghi" ),  20, 'Example 4' );
    is( max_product( "xyz", "w", "abcdefg", "hij" ),       21, 'Example 5' );

    done_testing();
}
else {
    say max_product(@ARGV);
}
