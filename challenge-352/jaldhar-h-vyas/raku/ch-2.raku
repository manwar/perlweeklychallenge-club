#!/usr/bin/raku

sub MAIN(
    *@nums
) {
    my @results;
    my $str = "";

    for @nums -> $num {
        $str ~= $num;
        @results.push($str.parse-base(2) %% 5);
    }

    say q{(}, @results.join(q{, }), q{)};
}