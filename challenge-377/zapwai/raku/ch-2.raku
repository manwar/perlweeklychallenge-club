use v6;

sub proc(@a) {
    say "Input: ", @a;
    my $cnt = 0;
    for 0 .. @a.end -> $i {
	for 0 .. @a.end -> $j {
	    next if $i == $j;
	    my $a = @a[$i];
	    my $b = @a[$j];
	    $cnt++ if ($a ~~ /^$b/) && ($a ~~ /$b$/);
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
