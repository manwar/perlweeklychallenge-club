#!/usr/bin/raku

sub p(Int $year) {
    return (($year + ($year div 4) - ($year div 100) +  ($year div 400)) % 7);
}

sub isLongYear(Int $year) {
    return p($year) == 4 || p($year - 1) == 3; 
}

sub MAIN() {
    (1900 .. 2100)
        .grep({ isLongYear($_); })
        .join(q{, })
        .say;
}
