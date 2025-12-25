#!/usr/bin/raku

sub MAIN(
    $codes,
    $names,
    $status
) {
    my @codes = $codes.words.map({ .subst(/(^^ \') || (\' $$)/, q{}, :g) });
    my @names = $names.words;
    my @status = $status.words;
    my @validity = ();

    for @codes.keys -> $i {
        @validity.push(
            @codes[$i].match(/^^ <alnum>+ $$/).so &&
            <electronics grocery pharmacy restaurant>.grep(@names[$i]).so &&
            @status[$i] eq 'true'
        );
    }

    say @validity.join(q{ });
}