use List::Util 'uniq';
use Math::Prime::Util::GMP 'factor';

sub f {
    my($n, $m) = @_;
    0 + uniq map $_ + ( $m *= .99999 ), factor $n
}

print f( @$_{'number', 'mode'} ) == $$_{expected_output} ? "ok\n" : "ERROR\n"
    for
    { number => 100061,  mode => 0, expected_output => 3 },
    { number => 971088,  mode => 0, expected_output => 3 },
    { number => 63640,   mode => 1, expected_output => 6 },
    { number => 988841,  mode => 1, expected_output => 2 },
    { number => 211529,  mode => 0, expected_output => 2 };
