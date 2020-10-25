subset Positive of UInt where * > 0;

unit sub MAIN(*@A where (.all ~~ Positive and .elems > 1));

my $A = gather {
    for @A.keys.combinations(1..@A.end) -> @C {
        my @N = @A;
        @N[@C].map(* *= -1);
        take [@N.sum, @C.elems] if @N.sum >= 0; 
    }
} 

say $A.classify(*.head).min.value.
       classify(*.tail).min.key;
