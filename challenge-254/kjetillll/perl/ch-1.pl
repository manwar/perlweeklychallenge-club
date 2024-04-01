sub is_three_power {
    my $n  = shift;
    my $try = $n**(1/3);
    int($try)   ** 3  == $n or
    int($try+1) ** 3  == $n;
}

use Test::More;
ok( is_three_power(27) );
ok( is_three_power(0) );
ok(!is_three_power(6) );
ok( is_three_power($_**3), "$_^3 = ".($_**3) ) for map int( $_ * rand 1e7 ), 0..10;
done_testing;
