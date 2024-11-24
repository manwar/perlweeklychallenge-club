#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 296 Task 2: Matchstick Square
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use builtin qw( true false );

BEGIN {
    # @ARGV = qw( -v -debug all )
    @ARGV = qw( -v )
        unless @ARGV;
}

use List::Util qw( sum all );
use Algorithm::Combinatorics qw( partitions );

sub matchstick_square_AC( @ints ) {
    my $total = sum( @ints );
    return false
        unless $total % 4 == 0;

    my $side_length = $total / 4;

    # my $iterator = partitions( \@ints, 4 );
    # while ( my $p = $iterator->next ) {
    for my $p ( partitions( \@ints, 4 ) ) {
        my @sums = map sum( $_->@* ), $p->@*;
        return true
            if all { $_ == $side_length } @sums;
    }
    return false;
}

sub matchstick_square_by_iterators( @ints ) {

    # The total sum of the matchstick lengths must be divisible by 4.
    my $total = sum( @ints );
    if ( $total % 4 != 0 ) {
        return false;
    }
    my $side_length = $total / 4;

    # Get a combination for the first side of the square.
    # my $n_found = 0;
    my $iterator_1 = get_exactly( $side_length, \@ints );
    while ( my ( $used_1, $rest ) = $iterator_1->() ) {
        # Use the remaining matchsticks to get a combination
        # for the second side of the square.
        my $iterator_2 = get_exactly( $side_length, $rest );
        while ( my ( $used_2, $rest ) = $iterator_2->() ) {
            my $iterator_3 = get_exactly( $side_length, $rest );
            while ( my ( $used_3, $rest ) = $iterator_3->() ) {
                # The remaining matchsticks automatically have
                # the correct length for the fourth side.
                # ++$n_found;
                return true;
            }
        }
    }
    # No combination found.
    return false;
    # return $n_found;
}

sub get_exactly( $target_sum, $ints ) {
    # Return an iterator.
    # Each call to the iterator returns two array_refs:
    # $used   refers to the next combination of numbers
    #         whose sum is $target_sum.
    # $rest   refers to the list of numbers that were not used
    #         for this combination.

    # Initialize the closure data for the iterator.
    # The iterator implements a broadth first tree traversal.
    # The queue entries (tree nodes, if you want) contain
    #     ( $used, $sum, $rest, $start_index ).
    # $used are the numbers collected so far for this branch,
    # and $sum is always updated to contain their sum
    # (so we don't need to sum them up again and again).
    # $rest are the numbers that still are not, or not yet, used.
    # We don't want to try again any numbers that are still in the
    # $rest list but we have already tried (which would lead to
    # reversed duplicates in the result set).
    # That's why we use in $start_index to keep the index for the next
    # number to try.
    my @queue = ( [ [], 0, $ints, 0 ] );

    return sub() {
        # Check whether we have reached the end before.
        return ()
            unless @queue;

        # Find the next matching combination.
        while ( @queue ) {
            my ( $used, $sum, $rest, $start_index ) = ( shift @queue )->@*;

            # Check the success criteria and return if it is met.
            return ( $used, $rest )
                if $sum == $target_sum;

            # If not, add more candidates.
            for my $index ( $start_index .. $rest->$#* ) {
                my $value = $rest->[$index];
                my $new_used = [ $used->@*, $value ];
                my $new_sum = $sum + $value;
                my $new_rest = [
                    $rest->@[ 0 .. $index - 1 ],
                    $rest->@[ $index + 1 .. $rest->$#* ],
                ];
                push @queue, [ $new_used, $new_sum, $new_rest, $index ]
                    if $new_sum <= $target_sum;
            }
        }
        # End of the list.
        return ();
    };
}

# *matchstick_square = \&matchstick_square_AC;
*matchstick_square = \&matchstick_square_by_iterators;

use Test2::V0 qw( -no_srand );
use Test2::Plugin::SRand seed => 20241124;

use Data::Dump qw( pp );

ok matchstick_square( 1, 2, 2, 2, 1 ),
    'Example 1: matchstick_square( 1, 2, 2, 2, 1 ) is true';
ok ! matchstick_square( 2, 2, 2, 4 ),
    'Example 2: matchstick_square( 2, 2, 2, 4 ) is false';
ok ! matchstick_square( 2, 2, 2, 2, 4 ),
    'Example 3: matchstick_square( 2, 2, 2, 2, 4 ) is false';
ok matchstick_square( 3, 4, 1, 4, 3, 1 ),
    'Example 4: matchstick_square( 3, 4, 1, 4, 3, 1 ) is true';
ok matchstick_square( 8, 7, 6, 5, 4, 3, 2, 1 ),
    'Extra 1: matchstick_square( 8, 7, 6, 5, 4, 3, 2, 1 ) is true';

my ( $n, $range ) = ( 15, 100000 );
my @random_sticks = map int( rand( $range ) ), 1..$n;
$random_sticks[0] += 4 - sum( @random_sticks ) % 4;
my $descr = "$n random sticks";
ok ! matchstick_square( @random_sticks ),
    "Extra 2: matchstick_square( $descr ) is false";

done_testing;

__END__

=head1
This is my documentation for Challenge 296.

We have to use *all* of the sticks to build the square.
If we could use just a subset, in Example 3 we could use the four sC<2>s
to build a square of side length C<2>, but the example should return C<false>.

As the sides of the square have to be all the same,
and we need to use I<all> the matches,
the sum of the matches' lengths has to be a multiple of four.
We can shortcut returning C<false> if it isn't.


If we could leave
