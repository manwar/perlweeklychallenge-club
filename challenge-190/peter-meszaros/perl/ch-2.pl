#!/usr/bin/env perl
#
=head1 Task 2: Decoded List

Submitted by: Mohammad S Anwar

You are given an encoded string consisting of a sequence of numeric characters:
0..9, $s.  Write a script to find the all valid different decodings in sorted
order.  Encoding is simply done by mapping A,B,C,D,... to 1,2,3,4,... etc.

=head2 Example 1

    Input: $s = 11
    Output: AA, K

    11 can be decoded as (1 1) or (11) i.e. AA or K

=head2 Example 2

    Input: $s = 1115
    Output: AAAE, AAO, AKE, KAE, KO

    Possible decoded data are:
    (1 1 1 5) => (AAAE)
    (1 1 15)  => (AAO)
    (1 11 5)  => (AKE)
    (11 1 5)  => (KAE)
    (11 15)   => (KO)

=head2 Example 3

    Input: $s = 127
    Output: ABG, LG

    Possible decoded data are:
    (1 2 7) => (ABG)
    (12 7)  => (LG)

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [  11, ['AA',     'K'],                     'Example 1'],
    [1115, ['AAAE', 'AAO', 'AKE', 'KAE', 'KO'], 'Example 2'],
    [ 127, ['ABG',   'LG'],                     'Example 3'],
];

sub _decode {
    my $s = shift;
    return '' unless @$s;

    my @res;

    my $c = $s->[0];
    if ($c ne '0') {
        my $char = chr($c + ord('A') - 1);
        for my $dec (_decode([$s->@[1 .. $#$s]])) {
            push @res, $char . $dec;
        }
    }

    if (@$s > 1) {
        $c = $s->[0] . $s->[1];
        if ($c <= 26 ) {
            my $char = chr($c + ord('A') - 1);
            for my $dec (_decode([$s->@[2 .. $#$s]])) {
                push @res, $char . $dec;
            }
        }
    }
    return @res;
}
sub decoded_list
{
    my $s = shift;

    my @s = split //, $s;
    my @res = _decode(\@s);
    return [sort @res];
}

for (@$cases) {
    is(decoded_list($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;


