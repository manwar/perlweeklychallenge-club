sub f {
    my($str, $target) = @_;
    grep !/0\d/ && eval == $target,
    map $str =~ s{ \d\B }{ [ $& . substr(' +-*', $_ % 4,1),  $_ >>= 2 ]->[0] }gxer =~ s/ //gr,
    0   ..   4 ** length($str) / 4  -  1
}
    
use Test::More;
is_deeply [ sort( f( @$_{'str','target'} ) ) ],
          [ sort( @{ @$_{'output'} }       ) ]
for {str => "123",  target => 6,  output => ["1*2*3", "1+2+3"] },
    {str => "105",  target => 5,  output => ["1*0+5", "10-5"] },
    {str => "232",  target => 8,  output => ["2*3+2", "2+3*2"] },
    {str => "1234", target => 10, output => ["1*2*3+4", "1+2+3+4"] },
    {str => "1001", target => 2,  output => ["1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"] };
done_testing;

