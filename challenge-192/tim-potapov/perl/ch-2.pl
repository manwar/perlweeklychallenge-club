#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util qw( sum uniq );
use feature    qw(say);

=pod

Task 2: Equal Distribution
You are given a list of integers greater than or equal to zero, @list.

Write a script to distribute the number so that each members are same.
If you succeed then print the total moves otherwise print -1.

=cut

sub equal_shares {
    my ( $list ) = @_;
    my $sum      = sum @$list;
    my $elems    = @$list;

    # Cant's be split since remainder.
    return -1 if $sum % $elems;

    my $goal_size_per_cell = $sum / $elems;
    my $count              = 0;
    my $first_index        = 0;
    my $last_index         = $#$list;
    my $n;
    my $run = sub { uniq( @$list ) > 1 };

    LOOP:
    while ( $run->() ) {
        say "";
        say "loop: (@$list)";
        for my $i ( $first_index .. $last_index ) {
            my $val = $list->[$i];
            next if $val == $goal_size_per_cell;

            # Tool big so lets split the cell.
            if ( $val > $goal_size_per_cell ) {
                if ( $i > $first_index ) {
                    $list->[$i]--;
                    $list->[ $i - 1 ]++;
                    $count++;
                    say "  <-- (@$list)";
                    last LOOP if not $run->();
                }
                if ( $i < $last_index ) {
                    $list->[$i]--;
                    $list->[ $i + 1 ]++;
                    $count++;
                    say "  --> (@$list)";
                    last LOOP if not $run->();
                }
            }
        }
        last if $n++ > 10;    # Stop infinite loop.
    }

    # After writing this, then I came up with the idea
    # to use a balanced binary tree approach...
    # maybe one day.

    $count;
}

my @cases = (

    {
        Name   => 'Example 1',
        Input  => [ 1, 0, 5 ],
        Output => 4,

        # Move #1: 1, 1, 4

        # (2nd cell gets 1 from the 3rd cell)
        #
        # Move #2: 1, 2, 3
        # (2nd cell gets 1 from the 3rd cell)
        #
        # Move #3: 2, 1, 3
        # (1st cell get 1 from the 2nd cell)
        #
        # Move #4: 2, 2, 2
        # (2nd cell gets 1 from the 3rd cell)

    },
    {
        Name   => 'Example 2',
        Input  => [ 0, 2, 0 ],
        Output => -1,

        # It is not possible to make each same.
    },
    {
        Name   => 'Example 3',
        Input  => [ 0, 3, 0 ],
        Output => 2,

        # Move #1: 1, 2, 0
        # (1st cell gets 1 from the 2nd cell)
        #
        # Move #2: 1, 1, 1
        # (3rd cell gets 1 from the 2nd cell)
    },
);

for ( @cases ) {
    is equal_shares( $_->{Input} ), $_->{Output}, $_->{Name};
}

done_testing();
