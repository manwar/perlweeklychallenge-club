#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Fibonacci Sum
# Find all possible combinations of unique Fibonacci numbers that sum to $n.
# Return [0] if no combinations are found.

sub get_fibs_up_to ($max_n) {
    return () if $max_n < 1;

    my @fibs = ( 1, 2 );
    while (1) {
        my $next = $fibs[-1] + $fibs[-2];
        last if $next > $max_n;
        push @fibs, $next;
    }
    return reverse @fibs;
}

sub find_fibonacci_sums ($max_n) {
    return [0] if $max_n < 1;

    my @all_fibs = get_fibs_up_to($max_n);
    my @solutions;

    my $backtrack;
    $backtrack = sub ( $idx, $current_combo, $current_sum ) {
        if ( $current_sum == $max_n ) {
            push @solutions, [@$current_combo];
            return;
        }

        for my $i ( $idx .. $#all_fibs ) {
            my $fib = $all_fibs[$i];
            next if $current_sum + $fib > $max_n;

            $backtrack->( $i + 1, [ @$current_combo, $fib ], $current_sum + $fib );
        }
    };

    $backtrack->( 0, [], 0 );

    return @solutions ? \@solutions : [0];
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is_deeply( find_fibonacci_sums(6),   [ [ 5, 1 ], [ 3, 2, 1 ] ], 'Example 1: sum 6' );
    is_deeply( find_fibonacci_sums(9),   [ [ 8, 1 ], [ 5, 3, 1 ] ], 'Example 2: sum 9' );
    is_deeply( find_fibonacci_sums(-19), [0],                       'Negative input returns 0' );
    is_deeply( find_fibonacci_sums(4),   [ [ 3, 1 ] ],              'Sum 4 = 3 + 1' );

    done_testing();
}
else {
    my $res = find_fibonacci_sums( $ARGV[0] );
    if ( $res->[0] eq '0' ) {
        say 0;
    }
    else {
        for my $combo (@$res) {
            say join( ' + ', @$combo ) . " = $ARGV[0]";
        }
    }
}
