use strict; use warnings; no warnings 'recursion'; use List::Util 'min'; use Test::More tests => 3;

sub ways {
    my( $amount, @coins ) = @_;
    $amount==0 ? \@coins : map ways($amount-$_, @coins, $_), grep $_ <= &min, 1,5,10,25,50
}
sub waystring {join('',map{{qw(1 P 5 N 10 D 25 Q 50 H)}->{$_}}@_)=~s,(.)\1*,length($&)."$1 ",reg=~s,\b1(\D),$1,gr}

print '9  --> '.waystring(@$_)."\n" for ways(9);
print '15 --> '.waystring(@$_)."\n" for ways(15);

is scalar ways(9)   => 2;
is scalar ways(15)  => 6;
is scalar ways(100) => 292;
