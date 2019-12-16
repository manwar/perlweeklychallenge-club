use v6;

sub MAIN ($in where * ~~ /^\d ** 7$/ = '2230120') {
    my ($y1, $y2, $m, $d) = ($in ~~ /^(\d)(\d\d)(\d\d)(\d\d)/)[0..3];
    die "First digit should be 1 or 2\n" if $y1 !~~ /<[12]>/;
    my $year = $y1 == 1 ?? "20$y2" !! "19$y2";
    die "Digits 4 and 5 should be a valid month number\n" unless $m ~~ /(0\d) | (1<[012]>)/;
    die "Digits 6 and 7 should be a valid day in month\n" unless $d ~~ /(<[012]>\d) | (3<[01]>)/;

    try {
        my $test = Date.new($year, $m, $d);
    }
    die "$in is equivalent to $year-$m-$d, which is an invalid date\n" if $!;
    say "$in is equivalent to $year-$m-$d.";
}
