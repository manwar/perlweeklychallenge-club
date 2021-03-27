#!/usr/bin/env raku

sub challenge(Str $name) returns Str {
    my $X = $name.wordcase;
    my $Y = $X ~~ /^[A|E|I|O|U|Y]<-[aeiouy]>/ ?? $X.lc !! $X.substr(1);

    qq:to/END/;
    $X, $X, bo-{$X.starts-with('B') ?? '' !! 'b'}$Y
    Bonana-fanna fo-{$X.starts-with('F') ?? '' !! 'f'}$Y
    Fee fi mo-{$X.starts-with('M') ?? '' !! 'm'}$Y
    $X!
    END
}

multi sub MAIN(Str $name) {
    say challenge($name);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ('Katie', "Katie, Katie, bo-batie\nBonana-fanna fo-fatie\nFee fi mo-matie\nKatie!\n"),
        ('Aaron', "Aaron, Aaron, bo-baron\nBonana-fanna fo-faron\nFee fi mo-maron\nAaron!\n"),
        # Should work with lowercase or uppercase input
        ('valerie', "Valerie, Valerie, bo-balerie\nBonana-fanna fo-falerie\nFee fi mo-malerie\nValerie!\n"),
        # Should work with names that start with vowels followed by consonants
        ('AMY', "Amy, Amy, bo-bamy\nBonana-fanna fo-famy\nFee fi mo-mamy\nAmy!\n"),
        ('Everett', "Everett, Everett, bo-beverett\nBonana-fanna fo-feverett\nFee fi mo-meverett\nEverett!\n"),
        # Wikipedia special cases
        ('Billy', "Billy, Billy, bo-illy\nBonana-fanna fo-filly\nFee fi mo-milly\nBilly!\n"),
        ('Fred', "Fred, Fred, bo-bred\nBonana-fanna fo-red\nFee fi mo-mred\nFred!\n"),
        ('Marsha', "Marsha, Marsha, bo-barsha\nBonana-fanna fo-farsha\nFee fi mo-arsha\nMarsha!\n")
    );

    for @tests -> ($name, $expected) {
        is(challenge($name), $expected);
    }

    done-testing;
}
