use v5.36;
use ntheory qw<rootint logint>;

sub task1_Cube ($n) { $n==0 ? 1 : $n ==      rootint($n, 3) ** 3 }
sub task1_PO3  ($n) { $n==0 ? 0 : $n == 3 **  logint($n, 3)      }


sub pm ($n) { [$n - 1, 0], [$n, 1], [$n + 1, 0] }
my @tests_Cubes = ( [27,1],[0,1],[6,0], map { pm( $_ ** 3  ) } 2..100, 2**16 );
my @tests_PO3   = ( [27,1],[0,0],[6,0], map { pm(  3 ** $_ ) } 2..32 );

use Test::More;
plan tests => @tests_Cubes + @tests_PO3;
for (@tests_Cubes) {
    my ($in, $expected) = @{$_};
    is 0+task1_Cube($in), $expected, "Cubes : $in -> $expected";
}
for (@tests_PO3) {
    my ($in, $expected) = @{$_};
    is 0+task1_PO3($in), $expected, "PO3   : $in -> $expected";
}
