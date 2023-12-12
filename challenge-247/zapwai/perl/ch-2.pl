use v5.30;
my $s = "abcdbca";
my $s = "cdeabeabfcdfabgcd";
my %h;
my @pairs;
my $max = 0;
foreach my $i (0 .. (length $s) - 2) {
    my $nom = substr $s, $i, 2;
    $h{$nom}++;
}
foreach my $key (keys %h) {
    if ($max < $h{$key}) {
	$max = $h{$key};
    }
}
foreach my $key (keys %h) {
    push @pairs, $key if ($max == $h{$key});
}
my $ans = $pairs[0];
foreach my $pair ( @pairs ) {
    $ans = $pair if ($pair le $ans);
}
say "Input: \$s = $s";
say "Output: $ans";
