#!/usr/bin/env perl
#
=head1

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
];

sub 
{
}

for (@$cases) {
    is(($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
