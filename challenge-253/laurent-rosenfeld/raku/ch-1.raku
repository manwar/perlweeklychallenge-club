sub split-strings (:$sep, :@strings) {
    my @result = grep { /\w+/ }, flat
        map { split $sep, $_ }, @strings;
    return @result;
}


my @tests = {
    'separator' => '.',
    'string' => ("one.two.three","four.five","six")
    }, {
    'separator' => '$',
    'string' => ('$perl$$', '$$raku$')};
for @tests -> %test {
    printf "%-30s => ",  %test<string>;
    say split-strings(sep => %test<separator>,
                      strings => %test<string>);
}
