use v6;

grammar My-custom-date {
    token TOP { <y1> <y2> <m> <d> }
    token y1  { <[12]> }
    token y2  { \d ** 2}
    token m   { 0\d | 1<[012]> }
    token d   { <[012]> \d | 3<[01]> }
}

sub MAIN ($in where * ~~ /^\d ** 7$/ = '2230120') {
    my $matched  = so My-custom-date.parse($in);
    say "Invalid input value $in" and exit unless $matched;
    my $year = $<y1> == 1 ?? "20$<y2>" !! "19$<y2>";
    try {
        my $test = Date.new($year, $<m>, $<d>);
    }
    say "ERROR: $in is equivalent to $year-$<m>-$<d>, which is an invalid date\n" and exit if $!;
    say "$in is equivalent to $year-$<m>-$<d>.";
}
