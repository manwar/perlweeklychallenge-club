#!/usr/bin/perl
use warnings;
use strict;

# Uncomment the following line to suppress warnings on 64 bit integers. You can
# than set MAX to 2 ** 64 (at least on some platforms).
#
# no warnings 'portable';

use constant MAX => 2 ** 32;

sub higher_integer_set_bits_naive {
    my ($n) = @_;
    my $bits = unpack '%b*', pack 'l', $n;
    1 until $bits == unpack '%b*', pack 'l', ++$n;
    return $n
}

sub higher_integer_set_bits {
    my ($n) = @_;

    my $binary = sprintf '%b', $n;
    if (-1 != (my $pos = rindex $binary, '01')) {
        substr $binary, $pos, 2, '10';
        my $suffix = substr $binary, $pos + 2, length $binary, "";
        my $ones = $suffix =~ tr/1//d;
        $suffix .= 1 x $ones;
        return oct "0b$binary$suffix";
    }

    my $pos = rindex $binary, '1';
    my $zeros = substr $binary, $pos + 1, length $binary, "";
    substr $binary, 1, 0, "0$zeros";
    return oct "0b$binary"
}

use Test::More;

is higher_integer_set_bits(3), 5, 'Example 1';
is higher_integer_set_bits(12), 17, 'Example 2';

is higher_integer_set_bits(2 ** 14 + 2 ** 15), 2 ** 16 + 1, '2^14 + 2^15';

my @random_data = map 1 + int rand MAX, 1 .. 1000;
for my $r (1 .. 100, @random_data) {
    is  higher_integer_set_bits($r),
        higher_integer_set_bits_naive($r),
        "over $r";
}

done_testing();

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive  => sub { higher_integer_set_bits_naive($_) for @random_data },
    clever => sub { higher_integer_set_bits($_)       for @random_data },
});

=head1 Higher Integer Set Bits

The naive variant uses the trick mentioned in L<perlfunc/unpack>:

    unpack '%b*', pack 'l', $n

It's a fast way to count number of 1's in the binary representation of $n.

"clever" is usually faster than "naive", but the results are widely
inconsistent. With 64 bit numbers, naive becomes faster.

Nevertheless, how does the "clever" algorithm work?

=over

=item 1.

If the binary number contains 01 anywhere, let's split the binary number into
four parts:

  | chaos         | last 01 | maybe ones | maybe zeros |
  | 10011011001...| 01      | 111        | 000         |

(Note that both ones and zeros might be empty.)

The next number is C<< chaos . 10 . zeros . ones >>.

=item 2.

The number has the form 11110000 (it doesn't contain 01 anywhere). We cut the
final zeros (might be none) and insert one more zeros after the first one.

  11110000         240
  1111             cut the zeros
  1 0000 111      insert them after the first 1
  1 0 0000 111    insert one more
  100000111       263

=back

A proof of correctness left as an exercise for the reader.

=cut
