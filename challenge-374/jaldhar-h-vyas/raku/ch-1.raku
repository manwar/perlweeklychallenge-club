#!/usr/bin/raku

sub MAIN(
    $str
) {
    my @results;

    for $str.match(/(<[aeiou]>+)/, :g) -> $match {
        my $len = $match.chars;
        for 0 .. $len - 5 -> $start {
            for $start + 5 .. $len -> $end {
                my $substring = $match.substr($start, $end - $start);
                if $substring.match(/
                    (<?before .*a>)
                    (<?before .*e>)
                    (<?before .*i>)
                    (<?before .*o>)
                    (<?before .*u>)
                /) {
                    @results.push($substring);
                }
            }
        }
    }

    say q{(}, @results.map({ "\"$_\"" }).join(q{, }), q{)};
}
