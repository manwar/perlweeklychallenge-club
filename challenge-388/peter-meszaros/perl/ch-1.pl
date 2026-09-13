#!/usr/bin/env perl
#
=head1 Task 1: Dyck Words

Submitted by: Roger Bell_West

A Dyck Word of order $n is a string of length 2x$n consisting of $n 'U' (Up)
characters and $n 'D' (Down) characters such that no initial prefix of the
string contains more 'D's than 'U's.  Write a script to return a list of all
valid Dyck words of length 2x$n, sorted in lexicographical (alphabetical)
order.

=head2 Example 1

    Input: $n = 1
    Output: ("UD")

=head2 Example 2

    Input: $n = 2
    Output: ("UDUD","UUDD")

=head2 Example 3

    Input: $n = 3
    Output: ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")

=head2 Example 4

    Input: $n = 0
    Output: ("")

=head2 Example 5

    Input: $n = 4
    Output: ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
             "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
             "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {n => 1, out => ["UD"], name => "Example 1"},
    {n => 2, out => ["UDUD","UUDD"], name => "Example 2"},
    {n => 3, out => ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"], name => "Example 3"},
    {n => 0, out => [""], name => "Example 4"},
    {n => 4, out => ["UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
                     "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
                     "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD"], name => "Example 5"},
);

sub dyckwords
{
    our $n = shift;
    our @paths = ();

    sub generate
    {
        my ($path, $up, $dn) = @_;

        if ($up == $n && $dn == $n) {
            push @paths, $path;
            return;
        }
        generate($path . 'D', $up, $dn + 1) if $dn < $up;
        generate($path . 'U', $up + 1, $dn) if $up < $n;
    }

    generate('', 0, 0);

    return \@paths;
}

for my $case (@cases) {
    my $got = dyckwords($case->{n});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
