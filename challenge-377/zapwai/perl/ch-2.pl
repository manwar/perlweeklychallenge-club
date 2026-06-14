use v5.38;

sub is_pruffix($a, $b) {
    return (($b =~ /^$a/) & ($b =~ /$a$/));
}

sub proc(@a) {
    say "Input: \@a = @a";
    my $cnt = 0;
    for my $i (0 .. $#a) {
	for my $j (0 .. $#a) {
	    next if ($j == $i);
	    $cnt++ if (is_pruffix($a[$i], $a[$j]));
	}
    }
    say "Output: $cnt";
}

my @array = ("a", "aba", "ababa", "aa");
proc(@array);
@array = ("pa", "papa", "ma", "mama");
proc(@array);
@array = ("abao", "ab");
proc(@array);
@array = ("abab", "abab");
proc(@array);
@array = ("ab", "abab", "ababab");
proc(@array);
@array = ("abc", "def", "ghij");
proc(@array);
