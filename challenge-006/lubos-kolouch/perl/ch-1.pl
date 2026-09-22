#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Compact number lists
# Take a list of numbers and print them in compact form.
# A range of 3 or more consecutive numbers is compacted to "start-end".
# Example: 1,2,3,4,9,10,14,15,16 -> 1-4,9,10,14-16

sub compact_number_list (@numbers) {
    return '' if !@numbers;

    my @sorted = sort { $a <=> $b } @numbers;

    my @compact;
    my $start = $sorted[0];
    my $end   = $sorted[0];

    my sub append_range ( $s, $e ) {
        if ( $e - $s >= 2 ) {
            push @compact, "$s-$e";
        }
        elsif ( $e - $s == 1 ) {
            push @compact, $s, $e;
        }
        else {
            push @compact, "$s";
        }
    }

    for my $num ( @sorted[ 1 .. $#sorted ] ) {
        if ( $num == $end + 1 ) {
            $end = $num;
        }
        elsif ( $num == $end ) {
            next;    # Skip duplicates
        }
        else {
            append_range( $start, $end );
            $start = $num;
            $end   = $num;
        }
    }

    append_range( $start, $end );
    return join( ',', @compact );
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( compact_number_list( 1, 2, 3, 4, 9, 10, 14, 15, 16 ), '1-4,9,10,14-16', 'Example 1' );
    is( compact_number_list( 1, 2, 3 ),                         '1-3',            'Continuous range >= 3' );
    is( compact_number_list( 1, 2 ),                            '1,2',            'Length 2 consecutive' );
    is( compact_number_list( 5 ),                               '5',              'Single number' );
    is( compact_number_list( 1, 3, 5 ),                         '1,3,5',          'Isolated numbers' );
    is( compact_number_list(),                                  '',               'Empty list' );

    done_testing();
}
else {
    my @input = map { split /,/, $_ } @ARGV;
    say compact_number_list(@input);
}
