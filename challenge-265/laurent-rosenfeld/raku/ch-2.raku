sub complete-word  ($in-str, @in-words) {
    my $letters = $in-str.comb.map({ .lc}).grep( /<[a..z]>/).Bag;
    my @result;
    for @in-words -> $word {
        push @result, $word if $letters ⊆ $word.comb.map({ .lc }).Bag;
    }
    return min(@result, :by( { $_.chars } ));
}

my @tests = ('aBc 11c', ('accbbb', 'abc', 'abbc')),
            ('Da2 abc', ('abcm', 'baacd', 'abaadc')),
            ('JB 007', ('jj', 'bb', 'bjb'));
for @tests -> @test {
    printf "%-8s - %-20s => ", @test[0], "@test[1]";
    say complete-word @test[0], @test[1];
}
