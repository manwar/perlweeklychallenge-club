use JSON::Fast;

subset Tiny-Str of Str where .chars < 10;

#| A.chars < 10, B.chars < 10, C.chars == A.chars + B.chars  
unit sub MAIN(Tiny-Str $A, Tiny-Str $B, $C where .chars == $A.chars + $B.chars);

my @terms := |from-json "terms.json".IO.slurp;
    
say interleaved($A, $B, $C);

sub interleaved($A, $B, $C) {
    for @terms[$A.chars].Array X @terms[$B.chars].Array -> (@A, @B) {
        for ($A, $B, @A, @B), ($B, $A, @B, @A) -> ($S1, $S2, @A1, @A2) {
            return 1 if roundrobin($S1.comb.rotor(@A1), $S2.comb.rotor(@A2))
                                                           .flat.join eq $C;
        }
    }

    return 0;
}
