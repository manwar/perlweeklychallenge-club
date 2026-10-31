#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Relative Sort (The Weekly Challenge 284 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl "2 3 9 3 1 4 6 7 2 8 5" "2 1 4 3 5 6"
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

This script sorts the elements of C<@list1> based on the relative order defined in C<@list2>. Elements in C<@list1> that are not in C<@list2> are placed at the end in ascending order.

=head1 FUNCTIONS

=head2 relative_sort($list1_ref, $list2_ref)

Sorts C<@list1> based on the order of elements in C<@list2>.

=over 4

=item * C<$list1_ref> - Reference to the first list of integers.

=item * C<$list2_ref> - Reference to the second list of integers defining the relative order.

=back

Returns an array reference of the sorted integers.

=cut

signature_for relative_sort => (
    method     => 0,
    positional => [ ArrayRef [Int], ArrayRef [Int] ],
);

sub relative_sort ( $list1_ref, $list2_ref ) {
    my %order;

    # Assign order to elements in @list2
    my $idx = 0;
    for my $num (@$list2_ref) {
        $order{$num} = $idx++;
    }

    # Separate elements that are in @list2 and not in @list2
    my @in_list2;
    my @not_in_list2;

    for my $num (@$list1_ref) {
        if ( exists $order{$num} ) {
            push @in_list2, $num;
        }
        else {
            push @not_in_list2, $num;
        }
    }

    # Sort elements in @list1 that are in @list2 based on the order in @list2
    @in_list2 = sort { $order{$a} <=> $order{$b} || $a <=> $b } @in_list2;

    # Sort elements not in @list2 in ascending order
    @not_in_list2 = sort { $a <=> $b } @not_in_list2;

    # Combine the two lists
    my @result = ( @in_list2, @not_in_list2 );

    return \@result;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    if ( @args == 2 ) {
        my @list1 = map { int($_) } split( /\s+/, $args[0] );
        my @list2 = map { int($_) } split( /\s+/, $args[1] );
        my $out   = relative_sort( \@list1, \@list2 );
        say 'Output: (' . join( ', ', @$out ) . ')';
        return;
    }
    die "Usage: perl $0 [\"list1\" \"list2\"]\n";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            list1    => [ 2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5 ],
            list2    => [ 2, 1, 4, 3, 5, 6 ],
            expected => [ 2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9 ],
        },
        {
            label    => 'Example 2',
            list1    => [ 3, 3, 4, 6, 2, 4, 2, 1, 3 ],
            list2    => [ 1, 3, 2 ],
            expected => [ 1, 3, 3, 3, 2, 2, 4, 4, 6 ],
        },
        {
            label    => 'Example 3',
            list1    => [ 3, 0, 5, 0, 2, 1, 4, 1, 1 ],
            list2    => [ 1, 0, 3, 2 ],
            expected => [ 1, 1, 1, 0, 0, 3, 2, 4, 5 ],
        },
        {
            label    => 'Additional Test',
            list1    => [ 7, 5, 9, 4, 8, 6 ],
            list2    => [ 5, 7, 6 ],
            expected => [ 5, 7, 6, 4, 8, 9 ],
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is_deeply(
            relative_sort( $case->{list1}, $case->{list2} ),
            $case->{expected},
            $case->{label}
        );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
