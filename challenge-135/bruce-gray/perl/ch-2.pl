use Modern::Perl;
use List::Util qw<sum>;
use Test::More;

my @tests = (
    [ '2936921' => 1 ],
    [ '1234567' => 0 ],
    [ 'B0YBKL9' => 1 ],
);
plan tests => 0+@tests;

# Based on my original code from RosettaCode.
BEGIN {
    my $c = 0;
    my %base36  = map { $_ => $c++ } 0..9, 'A'..'Z';
    my @weights = ( 1, 3, 1, 7, 3, 9 );
    sub sedol {
        die if @_ != 1;
        my ($s) = @_;
    
        my @vs = @base36{ split '', $s };
        die if grep { not defined } @vs;
        my $checksum = sum map { $vs[$_] * $weights[$_] } keys @vs;
        return $s . ((10 - $checksum % 10) % 10);
    }
}
sub valid_sedol {
    die if @_ != 1;
    my ($s) = @_;
    return 0+( $s eq sedol( substr($s,0,-1) ) );
}

for (@tests) {
    my ( $input, $expected ) = @{$_};
    my $got = valid_sedol($input);
    is $got, $expected, "valid_sedol('$input') == $expected";
}
