use v6;
use Test;

multi sub infix:<+∩>( $stones, $jewels )
{
    $stones.Str +∩ $jewels.Str
}

multi sub infix:<+∩>( Str $stones, Str $jewels )
{
    $stones.split( '', :skip-empty ) +∩ $jewels.split( '', :skip-empty ).Set
}

multi sub infix:<+∩>( Iterable $stones, Set $jewels )
{
    $stones.grep({ $_ ∈ $jewels })
}

ok( ( "chancellor"   +∩ "chocolates" ).elems == 8 );
ok( ( "chocolatiers" +∩ "chancellor" ).elems == 9 );
ok( ( "bottle" +∩ "beer" ).elems == 2 );
