#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Dyck Word
# Generate all valid Dyck words of length 2*$n consisting of 'U' and 'D'
# sorted in lexicographical order.

sub dyck_words ($n) {
    return [''] if $n == 0;

    my @result;

    my $generate;
    $generate = sub ( $current, $u_count, $d_count ) {
        if ( $u_count == $n && $d_count == $n ) {
            push @result, $current;
            return;
        }

        # 'D' comes before 'U' lexicographically
        if ( $d_count < $u_count ) {
            $generate->( $current . 'D', $u_count, $d_count + 1 );
        }
        if ( $u_count < $n ) {
            $generate->( $current . 'U', $u_count + 1, $d_count );
        }
    };

    $generate->( '', 0, 0 );
    return \@result;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is_deeply( dyck_words(1), ['UD'], 'Example 1' );
    is_deeply( dyck_words(2), [ 'UDUD', 'UUDD' ], 'Example 2' );
    is_deeply(
        dyck_words(3),
        [ 'UDUDUD', 'UDUUDD', 'UUDDUD', 'UUDUDD', 'UUUDDD' ],
        'Example 3'
    );
    is_deeply( dyck_words(0), [''], 'Example 4' );
    is_deeply(
        dyck_words(4),
        [
            'UDUDUDUD', 'UDUDUUDD', 'UDUUDDUD', 'UDUUDUDD', 'UDUUUDDD',
            'UUDDUDUD', 'UUDDUUDD', 'UUDUDDUD', 'UUDUDUDD', 'UUDUUDDD',
            'UUUDDDUD', 'UUUDDUDD', 'UUUDUDDD', 'UUUUDDDD'
        ],
        'Example 5'
    );

    done_testing();
}
else {
    my $n = int( $ARGV[0] );
    say join( ', ', @{ dyck_words($n) } );
}
