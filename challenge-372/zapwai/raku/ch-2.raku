use v6;

sub proc($s) {
    say "Input: $s";
    my %h;
    my @s = $s.comb;

    for 0 ..^ @s.end -> $i {
	my $letter = @s[$i];
	next if %h{$letter}:exists;
	my $diff = -1;
	for $i + 1 .. @s.end -> $j {
	    if @s[$j] eq $letter {
		my $new_diff = $j - $i - 1;
		$diff = $new_diff if $new_diff > $diff;
	    }
	}
	%h{$letter} = $diff;
    }
    
    my $max = %h.values.max // -1;
    say "Output: $max";
}

my $s = "aaaaa";
proc($s);
$s = "abcdeba";
proc($s);
$s = "abbc";
proc($s);
$s = "abcaacbc";
proc($s);
$s = "laptop";
proc($s);
