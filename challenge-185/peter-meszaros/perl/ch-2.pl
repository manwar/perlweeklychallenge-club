#!/usr/bin/env perl
#
=head1 Task 2: Mask Code

Submitted by: Mohammad S Anwar

You are given a list of codes in many random format.  Write a script to mask
first four characters (a-z,0-9) and keep the rest as it is.

=head2 Example 1

    Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
    Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')

=head2 Example 2

    Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
    Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [['ab-cde-123', '123.abc.420', '3abc-0010.xy'],
        ['xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy'], "Example 1"],
    [['1234567.a',    'a-1234-bc',  'a.b.c.d.e.f'],
        ['xxxx567.a',    'x-xxx4-bc',  'x.x.x.x.e.f'], "Example 2"],
];

sub mask_code
{
    my $list = shift;

    for my $code (@$list) {
        my $count = 0;
        $code =~ s/([a-z0-9])/
            if ($count < 4) {
                $count++;
                'x';
            } else {
                $1;
            }
        /eg;
    }
    return $list;
}

for (@$cases) {
    is(mask_code($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
