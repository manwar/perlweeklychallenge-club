#!/usr/bin/env perl
#
=head1 Task 1: MAC Address

Submitted by: Mohammad S Anwar

You are given MAC address in the form i.e. hhhh.hhhh.hhhh.  Write a script to
convert the address in the form hh:hh:hh:hh:hh:hh.

=head2 Example 1

    Input:  1ac2.34f0.b1c2
    Output: 1a:c2:34:f0:b1:c2

=head2 Example 2

    Input:  abc1.20f1.345a
    Output: ab:c1:20:f1:34:5a

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["1ac2.34f0.b1c2", "1a:c2:34:f0:b1:c2", "Example 1"],
    ["abc1.20f1.345a", "ab:c1:20:f1:34:5a", "Example 2"],
];

sub mac_address
{
    my $mac = shift;
    $mac =~ s/\.//g;
    $mac =~ s/(.{2})/$1:/g;
    $mac =~ s/:$//;
    return $mac;
}

for (@$cases) {
    is(mac_address($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
