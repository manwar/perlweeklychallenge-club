#!/usr/bin/env perl
#
=head1 Task 1: Zip List 

Submitted by: Mohammad S Anwar

You are given two list @a and @b of same size.  Create a subroutine sub zip(@a,
@b) that merge the two list as shown in the example below.

=head2 Example

    Input:  @a = qw/1 2 3/; @b = qw/a b c/;
    Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
            zip(@b, @a) should return qw/a 1 b 2 c 3/;

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[[qw/1 2 3/], [qw/a b c/]], [qw/1 a 2 b 3 c/], 'Example 1'],
    [[[qw/a b c/], [qw/1 2 3/]], [qw/a 1 b 2 c 3/], 'Example 2'],
];

sub zip_list 
{
    my $aref = $_[0]->[0];
    my $bref = $_[0]->[1];

    my @result;
    for my $i (0 .. $#$aref) {
        push @result, $aref->[$i], $bref->[$i];
    }
    return \@result;
}

for (@$cases) {
    is(zip_list($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
