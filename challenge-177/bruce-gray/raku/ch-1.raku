sub is_damm_valid ( UInt $N --> Bool ) {
    constant @table = <0317598642 7092154863 4206871359 1750983426 6123045978
                       3674209581 5869720134 8945362017 9438617205 2581436790>».comb».Int;

    my $i = 0;
    $i = @table[$i][$_] for $N.comb;
    return $i == 0;
}
say is_damm_valid($_) for 5724, 5727;
