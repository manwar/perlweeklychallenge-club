use Modern::Perl;
use experimental qw<signatures postderef>;
use List::Util   qw<sum0 reductions>;

use constant Factorials => [ 1, reductions { $a * $b } 1..9 ];
sub is_factorion ( $n ) {
    return $n == sum0 Factorials->@[ split '', $n ];
}

say join ', ', map  { 0 + is_factorion($_) } 145, 123;
say join ', ', grep {     is_factorion($_) } 0 .. 2_000_000;

# Output:
#   1, 0
#   1, 2, 145, 40585
