#!/usr/bin/perl

=head1

Week 185:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-185

Task #2: Mask Code

    You are given a list of codes in many random format.

    Write a script to mask first four characters (a-z,0-9) and keep
    the rest as it is.

=cut

use v5.36;
use Test2::V0;

is mask_code('ab-cde-123', '123.abc.420', '3abc-0010.xy'),
   [ 'xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy' ],
   'Example 1';

is mask_code('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f'),
   [ 'xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f' ],
   'Example 2';

done_testing;

#
#
# METHOD

sub mask_code(@list) {
    my @mc = ();
    foreach my $entry (@list) {
        my $mask = '';
        my $i    = 0;

        foreach my $char (split //, $entry) {
            ($i >= 4) && ($mask .= $char) && next;
            ($char !~ /^[a-z0-9]$/) && ($mask .= $char) && next;
            $mask .= 'x';
            $i++;
        }

        push @mc, $mask;
    }

    return \@mc;
}
