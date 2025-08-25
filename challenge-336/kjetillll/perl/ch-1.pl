use v5.10; use strict; use warnings; use List::Util qw( uniq ); use Math::Prime::Util::GMP qw( factor );

sub f {
    my @a = sort { $a <=> $b } @_;
    for my $size ( uniq factor 0+@a ){
        my @g = @a;
        uniq( splice @g, 0, $size ) == 1 or next while @g;
        return 1
    }
    return 0
}

my($true,$false)=(1,0);
say pop(@$_) == f(@$_) ? "ok" : "error " for
[ 1,1,2,2,2,2              => $true  ],  #  Groups: (1,1), (2,2), (2,2)
[ 1,1,1,2,2,2,3,3          => $false ],  #  Groups: (1,1,1), (2,2,2), (3,3)
[ 5,5,5,5,5,5,7,7,7,7,7,7  => $true  ],  #  Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)
[ 1,2,3,4                  => $false ],  #
[ 8,8,9,9,10,10,11,11      => $true  ],  #  Groups: (8,8), (9,9), (10,10), (11,11)

