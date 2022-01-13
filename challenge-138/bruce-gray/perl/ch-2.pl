use strict;
use warnings;
use 5.026;

use experimental qw<signatures>;
use ntheory      qw<forcomp>;
use List::Util   qw<sum>;
use Test::More;

use Memoize;
memoize('templates_for_size');

#   templates_for_size(3) returns ['a1 a1 a1',   'a1 a2',   'a2 a1',   'a3']
sub templates_for_size ( $size ) {
    my @r;

    forcomp { push @r, join ' ', map "a$_", @_ } $size;

    return \@r;
}

#   partition_sums(789) returns (24, 96, 87, 789) because '7'+'8'+'9'=24, '7'+'89'=96, '78'+'9'=87, and '789'=789
sub partition_sums ( $n ) {
    my $unpack_templates_aref = templates_for_size(length $n);

    return map { sum unpack $_, $n } @{$unpack_templates_aref};
}

sub can_partition_to_sqrt ( $n ) {
    my $r = int sqrt $n;
    die "$n is not a perfect square" if $r ** 2 != $n;

    return 0 + !! grep { $_ == $r } partition_sums($n);
}


my @tests = (
    # From examples in task description:
    [    81, 1 ],
    [  9801, 1 ],
    [    36, 0 ],

    # Regression tests
    [     72 ** 2, 0 ],

    [     36 ** 2, 1 ], # 36² == 1296,  1+29+6 == 36. Finds single-sided insufficient algorithms.
    [ 165607 ** 2, 0 ],

    # From the far edge of https://oeis.org/A038206/b038206.txt :
    [ 1028956743 ** 2, 0 ],
    [ 1028956744 ** 2, 1 ],
    [ 1028956745 ** 2, 0 ],

);


use constant USE_LONG_TESTS => 1;
plan tests => @tests + (USE_LONG_TESTS ? 2 : 0);

for (@tests) {
    my ( $input, $expected ) = @{$_};
    is can_partition_to_sqrt($input),   $expected,
      "can_partition_to_sqrt($input) == $expected";
}

if (USE_LONG_TESTS) {
    # The squares for which can-partition-to-sqrt returns True are an OEIS sequence.
    # The square-roots of those squares are also an OEIS sequence.
    # Test all the elements given on the OEIS web pages. (49 elements, and 35 elements).
    use constant A038206 => [ 0, 1, 9, 10, 36, 45, 55, 82, 91, 99, 100, 235, 297, 369, 370, 379, 414, 657, 675, 703, 756, 792, 909, 918, 945, 964, 990, 991, 999, 1000, 1296, 1702, 1782, 2223, 2728, 3366, 3646, 3682, 4132, 4879, 4906, 4950, 5050, 5149, 5292, 6832, 7191, 7272, 7389 ];
    use constant A104113 => [ 0, 1, 81, 100, 1296, 2025, 3025, 6724, 8281, 9801, 10000, 55225, 88209, 136161, 136900, 143641, 171396, 431649, 455625, 494209, 571536, 627264, 826281, 842724, 893025, 929296, 980100, 982081, 998001, 1000000, 1679616, 2896804, 3175524, 4941729, 7441984 ];

    my @got1 = grep { can_partition_to_sqrt( $_ ** 2 ) }                 0 ..      A038206->[-1];
    my @got2 = grep { can_partition_to_sqrt( $_      ) } map { $_ ** 2 } 0 .. sqrt A104113->[-1];

    is_deeply \@got1, A038206, 'Exact match of https://oeis.org/A038206';
    is_deeply \@got2, A104113, 'Exact match of https://oeis.org/A104113';
}
