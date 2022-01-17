my $max = 4000;
my @pentanums = map { (3 * $_² - $_)/2 }, 1..$max;
my %penta = map {@pentanums[$_] => $_+1}, 0..$max-1;
for @pentanums.combinations(2) -> $comb {
    next unless %penta{$comb.sum}:exists;
    next unless %penta{$comb[1]-$comb[0]}:exists;
    say $comb, " = Pentagon numbers N° %penta{$comb[0]} and %penta{$comb[1]}";
    say "Sum is ", $comb.sum, " (Pentagon number ", %penta{$comb.sum}, ")";
    say "Difference is ", $comb[1]-$comb[0], " (Pentagon number ", %penta{$comb[1]-$comb[0]}, ")";
    last;
}
say now - INIT now, " seconds";
