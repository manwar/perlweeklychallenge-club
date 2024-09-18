use v5.38;
my $str = "a";
proc($str);
$str = "aB2";
proc($str);
$str = "PaaSW0rd";
proc($str);
$str = "turbbbbot";
proc($str);
$str  = "111";
proc($str);

sub proc($str) {
    say "Input: $str";
    my $len = length $str;
    my $len_diff = 0;
    if ($len < 6) {
	$len_diff = 6 - $len;
    } elsif ($len > 20) {
	$len_diff = $len - 20;
    }
    # len_diff is the number of changes needed because of length requirement
    
    # Check for repeated letters (3 or more)
    my @l = split "", $str;
    my @len;
    my $hits = 0;
    for my $i (0 .. $#l - 1) {
	if ($l[$i] eq $l[$i+1]) {
	    $hits++;
	} else {
	    if ($hits > 1) {
		push @len, ++$hits;
	    }
	    $hits = 0;
	}
    }
    if ($hits > 1) {
	push @len, ++$hits;
    }
    my $steps = 0;
    for my $l (@len) {
	$steps += int($l/3);
    }
    # steps is the number of changes needed to remove repeats

    my $lflag = 1;
    my $uflag = 1;
    my $dflag = 1;
    $lflag = 0 if ($str =~ /[a-z]/);
    $uflag = 0 if ($str =~ /[A-Z]/);
    $dflag = 0 if ($str =~ /\d/);
    my $tally = $lflag + $uflag + $dflag;
    # tally is the number of missing constraints (lower/upper/digit)

    #say "\t\t",$len_diff, $steps, $tally;
    my $out_val = $len_diff + $steps;
    if ($out_val < $tally) {
	$out_val += $tally - $out_val;
    }
    # Tally is only needed if tally > len_diff + steps.
    say "Output: ", $out_val;
}

