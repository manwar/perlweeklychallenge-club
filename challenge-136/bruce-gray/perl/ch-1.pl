use 5.24.0;
use warnings;
use experimental qw<signatures>;
use Test::More;

sub gcd ( $x, $y ) {
    # From https://xlinux.nist.gov/dads/HTML/euclidalgo.html
    return $y == 0 ? $x : gcd($y, $x % $y);
}

sub is_power_of_two ( $x ) {
    # From http://graphics.stanford.edu/~seander/bithacks.html#DetermineIfPowerOf2
    return ( $x & ($x - 1) ) == 0;
}

sub are_two_friendly ( $m, $n ) {
    my $g = gcd($m, $n);
    return 0 + ( $g > 1 && is_power_of_two($g) );
}

my @tests = (
    [ [ 8, 24], 1 ],
    [ [26, 39], 0 ],
    [ [ 4, 10], 1 ],
    
    [ [40, 48], 1 ],
    [ [ 8, 64], 1 ],
    [ [ 8,  1], 0 ],

);
plan tests => 0+@tests;
for (@tests) {
    my ( $input_aref, $expected ) = @{$_};
    is are_two_friendly(@{$input_aref}), $expected;
}
