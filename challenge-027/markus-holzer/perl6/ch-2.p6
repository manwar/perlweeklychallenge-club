use Test;
use Scalar::History; # See the README

my Int $x := Scalar::History.create(10, Int);
$x = 20;
$x -= 5;

ok( $x == 15 );
is-deeply( $x.VAR.get-history, (10, 20) );