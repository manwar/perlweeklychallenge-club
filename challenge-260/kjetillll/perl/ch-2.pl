use strict; use warnings;
sub permute{@_?map{my$i=$_;map[$_[$i],@$_],permute(@_[0..$i-1,$i+1..$#_])}0..$#_:[]}

sub f {
    my( $word, %n ) = shift;
    $n{ $_ } //= keys %n for sort map join('',@$_), permute( split //, $word );
    $n{ $word }
}



#========== Test ========================================
use Test::More tests=>3;
is( f( $$_{input} ), $$_{output} ) for
    {
        input  => 'CAT',
        output => 3
    },
    {
        input => 'GOOGLE',
        output => 88
    },
    {
        input => 'SECRET',
        output => 255
    };
