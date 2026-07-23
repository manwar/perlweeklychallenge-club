#!/usr/bin/raku

sub generate($prefix, $index, @chars, @combinations) {

    if $index == @chars.elems {
        @combinations.push($prefix);
        return;
    }

    my $char = @chars[$index];

    if $char eq '?' {
        generate($prefix ~ '0', $index + 1, @chars, @combinations);
        generate($prefix ~ '1', $index + 1, @chars, @combinations);
    }
    else {
        generate($prefix ~ $char, $index + 1, @chars, @combinations);
    }
}

sub MAIN(
    $str
) {
    my @chars = $str.comb;
    my @combinations;

    generate(q{}, 0, @chars, @combinations);

    say q{(}, @combinations.map({ "\"$_\"" }).join(q{, }), q{)};
}
