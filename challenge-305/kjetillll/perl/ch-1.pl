
sub bpp { my $n = 0; map is_prime($n=$n*2+$_), @_ } #binary prefix prime

sub is_prime {
    my $n = shift;
    return 1 if $n==2 or $n==3;
    return 0 if $n<2 or $n%2==0 or $n%3==0;
    my($i, $n_sqrt) = (5, int sqrt $n);
    ! ( ($n%$i) * ($n%($i+2)) ) and return 0 or $i += 6 while $i <= $n_sqrt;
    return 1
}

use Test::More tests => 3;
is_deeply [ bpp( @{ $$_{input} } ) ], $$_{output} for
{ input => [1,0,1],output => [map/true/?1:0,qw(false true true)] },
{ input => [1,1,0],output => [map/true/?1:0,qw(false true false)] },
{ input => [1,1,1,1,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,1],
  output => [map/t/?1:0,qw(false true true false false true false false false false
                           false false false false false false false false false true)] }
