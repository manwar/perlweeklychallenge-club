use v5.30.0;
no warnings;
my @words = ("Perl", "Rust", "Raku");
say "Input: \@words = (" . join(",",@words) . ")";
$words[$_] = lc $words[$_] for (0 .. $#words);
my @intersection = split("",$words[0]);
for my $i (1 .. $#words) {
    my @letters = split("",$words[$i]);
    for my $j (0 .. $#intersection) {
	splice(@intersection, $j, 1) unless ($intersection[$j] ~~ @letters);
    }
}
say "Output: @intersection";
