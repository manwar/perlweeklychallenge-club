use JSON::Fast;

subset Tiny-Str of Str where .chars < 10;

#| A.chars < 10, B.chars < 10, C.chars == A.chars + B.chars  
unit sub MAIN(Tiny-Str $A, Tiny-Str $B, $C where .chars == $A.chars + $B.chars);

my @terms := |from-json "terms.json".IO.slurp;
    
say interleaved($A, $B, $C);

sub interleaved($S1, $S2, $C) {
    for ($S1, $S2), ($S2, $S1) -> ($A, $B) {
        for @terms[$A.chars].Array X @terms[$B.chars].Array -> (@A, @B) {
            return 1 if roundrobin($A.comb.rotor(@A), $B.comb.rotor(@B))
                                                        .flat.join eq $C;
        }
    }

    return 0;
}
