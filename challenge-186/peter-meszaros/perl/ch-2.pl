#!/usr/bin/env perl
#
=head1 Task 2: Unicode Makeover

Submitted by: Mohammad S Anwar

You are given a string with possible unicode characters.  Create a subroutine
sub makeover($str) that replace the unicode characters with ascii equivalent.
For this task, let us assume it only contains alphabets.

=head2 Example 1

    Input: $str = 'ÃÊÍÒÙ';
    Output: 'AEIOU'

=head2 Example 2

    Input: $str = 'âÊíÒÙ';
    Output: 'aEiOU'

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use utf8;
use Text::Unidecode;

my $cases = [
    ['ÃÊÍÒÙ',   'AEIOU', "Example 1"],
    ['âÊíÒÙ',   'aEiOU', "Example 2"],
];

sub unicode_makeover
{
    return unidecode(shift);
}

for (@$cases) {
    is(unicode_makeover($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
