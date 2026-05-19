#!/usr/bin/env raku

use Test;

my @examples = (
    { in => "aeiou", out => ["aeiou"] },
    { in => "aaeeeiioouu", out => ["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"] },
    { in => "aeiouuaxaeiou", out => ["aeiou", "aeiouu", "aeiouua", "eiouua", "aeiou"] },
    { in => "uaeiou", out => ["uaeio", "uaeiou", "aeiou"] },
    { in => "aeioaeioa", out => [] },
);

for @examples -> $ex {
    is-deeply count-vowel($ex<in>), $ex<out>;
}

done-testing;

sub count-vowel($str) {
    my @count;
    my $len = $str.chars;

    for 0 .. $len - 1 -> $start {
        for 5 .. $len - $start -> $length {
            my $sub = $str.substr($start, $length);
            next unless $sub ~~ /^<[aeiou]>+$/;
            next unless $sub ~~ /a/ && $sub ~~ /e/ && $sub ~~ /i/ && $sub ~~ /o/ && $sub ~~ /u/;
            @count.push($sub);
        }
    }

    return @count;
}
