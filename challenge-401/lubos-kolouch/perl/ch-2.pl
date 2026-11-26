#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-2.pl - Reconstruct Digits

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 401, Task 2: Reconstruct Digits.
Counts character frequencies in a scrambled string of English digit words
(C<zero> through C<nine>) and returns the digits in ascending order.

=head1 FUNCTIONS

=head2 reconstruct_digits($str)

Returns a string of digits C<0>-C<9> in ascending order reconstructed from
the scrambled English digit names in C<$str>.

=cut

signature_for reconstruct_digits => (
    method     => 0,
    positional => [Str],
);

sub reconstruct_digits ($str) {
    my %freq;
    for my $ch ( split //msx, $str ) {
        $freq{$ch}++;
    }

    my @count = (0) x 10;
    $count[0] = $freq{'z'} // 0;
    $count[2] = $freq{'w'} // 0;
    $count[4] = $freq{'u'} // 0;
    $count[6] = $freq{'x'} // 0;
    $count[8] = $freq{'g'} // 0;

    $count[1] = ( $freq{'o'} // 0 ) - $count[0] - $count[2] - $count[4];
    $count[3] = ( $freq{'h'} // 0 ) - $count[8];
    $count[5] = ( $freq{'f'} // 0 ) - $count[4];
    $count[7] = ( $freq{'s'} // 0 ) - $count[6];
    $count[9] = ( $freq{'i'} // 0 ) - $count[5] - $count[6] - $count[8];

    my $result = q{};
    for my $digit ( 0 .. 9 ) {
        $result .= "$digit" x $count[$digit];
    }

    return $result;
}

is( reconstruct_digits('zroezerotwotwotwo'),                        '00222',      'Example 1' );
is( reconstruct_digits('sveeeinght'),                               '78',         'Example 2' );
is( reconstruct_digits('onenineninefive'),                          '1599',       'Example 3' );
is( reconstruct_digits('zeroonetwothreeeightfivesixsevenninefour'), '0123456789', 'Example 4' );
is( reconstruct_digits('ninenineninenine'),                         '9999',       'Example 5' );
done_testing();
