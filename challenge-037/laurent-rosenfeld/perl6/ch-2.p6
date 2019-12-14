use v6;
sub hrs2sec ($hms) {
    my ($hrs, $min, $sec) = split /\:/, $hms;
    return $hrs * 60² + $min * 60 + $sec;
}
sub sec2hrs (Numeric $sec) {
    my @duration = $sec.abs.polymod(60, 60);
    my $fmt = ($sec < 0 ?? "-" !! "") ~ "%d:%02d:%02d";
    return sprintf $fmt, @duration[2, 1, 0];
}

my @nov = 'november_2019.txt'.IO.lines[0..29].map({(.split(/\s+/))[3]});
my @dec = 'december_2019.txt'.IO.lines[0..29].map({(.split(/\s+/))[3]});
my @diff = @dec.map({hrs2sec $_}) Z- @nov.map({hrs2sec $_});
say "Daylight changes between Dec and Nov:";
for @diff.kv -> $k, $v { printf "%2d: %s\n", $k + 1, sec2hrs( $v) };
say "\nAverage change between Nov and Dec: ", sec2hrs ([+] @diff) / 30;
