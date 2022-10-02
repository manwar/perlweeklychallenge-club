sub task1 ( @a ) {
    my $seq = '00';
    return @a.map: {
        / ^ <[a..z]> ** 2  ( <[0..9]> ** 4 ) $ / or die;
        $seq++ ~ $0;
    }
}
# I could have used .subst, but then I could not detect bad input:
#   return @a.map: *.subst( / ^ <[a..z]> ** 2  ( <[0..9]> ** 4 ) $ /, { $seq++ ~ $0 } );
# If I used `».subst`, I would not need `.map`, but the sequences could be out of order.

use Test;
my @tests =
    ( <ab1234 cd5678 ef1342>,
      <001234 015678 021342> ),
    ( <pq1122 rs3334>,
      <001122 013334> ),
;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task1($in), $expected;
}
