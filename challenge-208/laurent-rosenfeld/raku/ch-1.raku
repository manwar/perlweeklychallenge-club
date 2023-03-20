sub min-sum-idx (@s1, @s2) {
    my $b1 = (map {@s1[$_] => $_ + 1}, 0..@s1.end).Bag;
    my $b2 = (map {@s2[$_] => $_ + 1}, 0..@s2.end).Bag;
    my $result = (map { $_ =>  $b1{$_} + $b2{$_}},
        ($b1 ∩ $b2).keys).Bag;
    my $min = $result.values.min;
    return grep {$result{$_} == $min}, $result.keys;
}

for (<Perl Raku Love>, <Raku Perl Hate>),
    (<A B C>, <D E F>), (<A B C>, <C A B>)
        -> @test {
            say "@test[0] - @test[1]".fmt("%-35s => "),
                min-sum-idx |@test;
}
