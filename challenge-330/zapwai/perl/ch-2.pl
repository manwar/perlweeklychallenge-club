use v5.38;

sub capitalize($w) {
    my $a = substr $w, 0, 1;
    my $b = substr $w, 1;
    return uc($a).lc($b);
    
}

sub proc($str) {
    say "Input: $str";
    my @words = split(" ", $str);
    my @out;
    foreach my $word (@words) {
	if (length $word < 3) {
	    push @out, lc($word);
	} else {
	    push @out, capitalize($word);
	}
    }
    my $o = join " ", @out;
    say "Output: $o";
}

my $str = "PERL IS gREAT";
proc($str);

$str = "THE weekly challenge";
proc($str);

$str = "YoU ARE A stAR";
proc($str);
