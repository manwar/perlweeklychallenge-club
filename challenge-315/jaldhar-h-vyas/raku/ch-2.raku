#!/usr/bin/raku

sub MAIN(
    $first,
    $second,
    $sentence
) {
    my $preceding = '<?after $first \s+ $second \s+ >';
    my @output = $sentence.match(/ <$preceding> (\w+) /, :g);
    say '(', @output.map({ "\"$_\"" }).join(', '), ')';
}

