#!/usr/bin/perl

=head1

Week 186:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-186

Task #1: Zip List

    You are given two list @a and @b of same size.

    Create a subroutine sub zip(@a, @b) that merge the two list.

=cut

use v5.36;
use Test2::V0;

my @a = qw/1 2 3/;
my @b = qw/a b c/;

is [ zip(\@a, \@b) ], [ qw/1 a 2 b 3 c/ ], 'example 1';
is [ zip(\@b, \@a) ], [ qw/a 1 b 2 c 3/ ], 'Example 2';

done_testing;

#
#
# METHOD

sub zip($a, $b) {
    my @list = (@$a, @$b);
    my $size = scalar @$a;

    my @zip = ();
    foreach my $i (0 .. $size-1) {
        push @zip, ($list[$i], $list[$i + $size]);
    }

    return @zip;
}
