#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 228 Task 2: Empty Array
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
BEGIN { $ENV{T2_RAND_SEED} = 228; }
use TestExtractor;

use List::Util qw( min );

sub empty_array_1( @int ) {
    # $verbose && print say "empty_array( @int )";
    my $n_ops = 0;
    while ( @int ) {
        $n_ops++;
        # $verbose && print print "Operation $n_ops: ";
        if ( $int[0] == min @int ) {
            # $verbose && print print "remove element $int[0]";
            shift @int;
        }
        else {
            # $verbose && print print "move $int[0] to the end";
            push @int, shift @int;
        }
        # $verbose && print say ": ( ", join( ", ", @int ), " )";
    }
    return $n_ops;
}

sub empty_array_2( @int ) {
    # $verbose && print say "empty_array( @int )";
    my $n_ops = 0;
    while ( @int ) {
        $n_ops++;
        # $verbose && print print "Operation $n_ops: ";
        my $min = min @int;
        # Remove the first element (we need to do this in any case).
        my $first = shift @int;
        # Add the (former) first element to the end if it is not the minimum.
        if ( $first != $min ) {
            push @int, $first;
            # $verbose && print print "move $first to the end";
        }
        else {
            # $verbose && print print "remove element $first";
        }
        # $verbose && print say " ( @int )";
    }
    return $n_ops;
}

sub empty_array_3a( @int ) {
    # $verbose && print say "empty_array( @int )";
    my $n_ops = 0;
    while ( @int ) {
        # Find the index of the lowest number.
        my $min = $int[0];
        my $index = 0;
        for ( 1..$#int ) {
            if ( $int[$_] < $min ) {
                $index = $_;
                $min = $int[$_];
            }
        }

        # Reorder the array,
        # moving all numbers left of the smallest number to the end in one step,
        # also deleting (that is: not copying) the smallest number.
        @int = (
            @int[ $index + 1 .. $#int ],
            $index > 0 ? @int[ 0 .. $index - 1 ] : (),
        );

        # This is worth '$index' single moving operations, plus one delete operation.
        $n_ops += $index + 1;
    }
    return $n_ops;
}

use List::MoreUtils qw( first_index );

sub empty_array_3b( @int ) {
    # $verbose && print say "empty_array( @int )";
    my $n_ops = 0;
    while ( @int ) {
        # Find the index of the lowest number.
        my $min = min @int;
        my $index = first_index { $_ == $min } @int;

        # Reorder the array,
        # moving all numbers left of the smallest number to the end in one step,
        # also deleting (that is: not copying) the smallest number.
        @int = (
            @int[ $index + 1 .. $#int ],
            $index > 0 ? @int[ 0 .. $index - 1 ] : (),
        );

        # This is worth '$index' single moving operations, plus one delete operation.
        $n_ops += $index + 1;
    }
    return $n_ops;
}

sub empty_array_4( @int ) {
    # $verbose && print say "empty_array( @int )";

    # Walk through the numbers starting with the lowest one.
    my $n_ops = 0;
    my @sorted = sort { $a <=> $b } @int;
    for my $current_lowest ( @sorted ) {
        # Find the index of the current lowest number.
        my $index = first_index { $_ == $current_lowest } @int;

        # Reorder the array,
        # starting with all numbers right of the smallest number,
        # and putting everything that was left of the smallest number behind.
        @int = (
            @int[ $index + 1 .. $#int ],
            $index > 0 ? @int[ 0 .. $index - 1 ] : (),
        );
        # $verbose && print say ": ( ", join( ", ", @int ), " )";

        # This is worth '$index' single moving operations, plus one delete
        # operation.
        # $verbose && print print "Operation $n_ops: move elements up to #$index,",
        #     " remove element $current_lowest";
        $n_ops += $index + 1;
    }
    return $n_ops;
}

sub empty_array_5( @int ) {
    # $verbose && print say "empty_array( @int )";

    my $n_ops = 0;

    # Sort the numbers, to get the order in which we will remove them,
    # Then walk through the numbers, starting with the lowest one.
    my @sorted = sort { $a <=> $b } @int;
    for my $current_smallest ( @sorted ) {
        # Find the position of our smallest number in the array.
        my $index = first_index { $_ == $current_smallest } @int;

        # $verbose && print print "Operation $n_ops: move elements up to #$index,",
        #     " remove element $current_smallest";

        # Move all numbers left of the smallest one to the end, in one step,
        # 'splicing' them away at the front and re-adding (push) them at the
        # end.
        # We only need to do that if there actually *are* any numbers left of
        # the smallest number.
        push @int, splice @int, 0, $index, ()
            if $index > 0;

        # Remove the smallest number, which is at the front now.
        shift @int;

        # What we did was worth '$index' single move operations, plus one
        # delete operation.
        $n_ops += $index + 1;

        # $verbose && print say ": ( ", join( ", ", @int ), " )";
    }
    return $n_ops;
}

sub empty_array( @int ) {
    # $verbose = 1;
    my @results = empty_array_1( @int );
    is [ empty_array_2( @int ) ], \@results, "empty_array_2 results are the same";
    is [ empty_array_3a( @int ) ], \@results, "empty_array_3a results are the same";
    is [ empty_array_3b( @int ) ], \@results, "empty_array_3b results are the same";
    is [ empty_array_4( @int ) ], \@results, "empty_array_4 results are the same";
    is [ empty_array_5( @int ) ], \@results, "empty_array_5 results are the same";
    return @results;
}

# run_tests;
# exit 0;

use Benchmark qw( :all :hireswallclock );

sub random_list( $n ) {
    my @a = 1..$n;
    my @b = ();
    while( @a ) {
        push @b, splice @a, int(rand(@a)), 1, ()
    };
    return @b;
}

my @input = (
    47,12,38,26,25,31,41,37,1,6,10,23,22,32,17,48,43,2,27,13,19,30,35,29,40,
    11,5,18,36,33,15,46,50,28,14,45,4,21,8,42,20,16,7,39,9,24,34,49,44,3,
);

$| = 1;
$verbose = 0;

for ( 10, 50, 100, 1000 ) {
    say "Benchmark using $_ values:";
    my @input = random_list( $_ );
    cmpthese( $_ > 100 ? -10 : -3, {
        'empty_array_1' => sub { empty_array_1( @input ) },
        # 'empty_array_2' => sub { empty_array_2( @input ) },
        # 'empty_array_3a' => sub { empty_array_3a( @input ) },
        # 'empty_array_3b' => sub { empty_array_3b( @input ) },
        # 'empty_array_4' => sub { empty_array_4( @input ) },
        'empty_array_5' => sub { empty_array_5( @input ) },
    } );
    say "";
}

1;

__DATA__
Test 1: Test with 10 values
Input: @int = ( 47, 12, 38, 26, 25, 31, 41, 37, 1, 6 )
Output: 28

Test 2: Test with 50 values
Input: @int = (47,12,38,26,25,31,41,37,1,6,10,23,22,32,17,48,43,2,27,13,19,30,35,29,40,11,5,18,36,33,15,46,50,28,14,45,4,21,8,42,20,16,7,39,9,24,34,49,44,3)
Output: 702

