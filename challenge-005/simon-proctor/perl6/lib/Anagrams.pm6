unit package Anagrams;

sub normal ( Str \word ) is pure {
    samemark( lc( word ), "a" )
}

sub order-string ( Str \word ) is export is pure {
    normal( word ).comb.sort( { $^a cmp $^b } ).join;
}

multi sub is-anagram-of( Str \target, Str \word where * eq target ) is export is pure { False; }

multi sub is-anagram-of( Str \target, Str \word where *.codes != target.codes ) is export is pure { False; }

multi sub is-anagram-of( Str \target, Str \word ) is export is pure {
    normal( target ) ne normal( word ) && order-string( target ) ~~ order-string( word );
}
