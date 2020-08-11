use Test;

# In Raku, all operators are just multi - functions.
# So we can easily define ourselves an infix left-associative element-of operator.
# It will take an `Iterable` (`Seq`, `Array`, `List`) on its left side and a `Set` on the right side.
# It returns a `Seq` of all elements of the left side that are present on the right side and that
# are part of our alphabet

multi sub infix:<\<∈>( Iterable $stones, Set $jewels ) returns Seq
{
    # constant runs at BEGIN time, so this work gets only done once
    constant \alphabet = ( 'a' .. 'z', 'A' .. 'Z' ).Set;
    $stones.grep({ $_ ∈ alphabet && $_ ∈ $jewels });
}

# Now we could call that good, but in true Raku spirit we provide additional
# versions of our operator to make using it easier.
# We don't need to repeat ourselves. We can rely on the multi-mechanism
# to do the right thing.

multi sub infix:<\<∈>( Iterable $stones, Iterable $jewels ) returns Seq
{
    $stones <∈ $jewels.Set
}

multi sub infix:<\<∈>( Str $stones, Str $jewels ) returns Str
{
    ( $stones.comb <∈ $jewels.comb ).join("")
}

# And here we finally use it to solve the problem
ok( ( ["b", "e", "e", "r"] <∈ ["b", "o", "t", "t", "l", "e"] ).elems == 3, "3 characters of 'beer' are also in 'bottle'" );
ok( ( "chancellor" <∈ "chocolates" ).chars == 8, "8 characters of 'chancellor' are also in 'chocolates'" );
ok( "chancellor" <∈ "chocolates" eq "chacello", "These characters are 'chacello'" );
