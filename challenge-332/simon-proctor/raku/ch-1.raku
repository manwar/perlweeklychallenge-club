#!/usr/bin/env raku

subset DateStr of Str where { my $r=False; try { Date.new($_); $r=True }; $r };

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is binary-date("2025-07-26"), "11111101001-111-11010";
    is binary-date("2000-02-02"), "11111010000-10-10";
    is binary-date("2024-12-31"), "11111101000-1100-11111";
}

sub binary-date( DateStr $d ) {
    $d.comb(/\d+/)>>.Int>>.base(2).join('-');
}

#| Given a date string output it in a binary format
multi sub MAIN(
    DateStr $d #= Valid Date String in yyyy-mm-dd format
) {
    say binary-date($d);
}
