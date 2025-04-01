use v5.38;
sub proc($str) {
    say "Input: \$str = $str";
    my @l = split '', $str;
    my @let;
    my @ind;
    for my $i (0 .. $#l) {
	if ($l[$i] =~ /[a-zA-Z]/) {
	    push @let, $l[$i];
	}
    }
    my @out;
    for my $i (0 .. $#l) {
	if ($l[$i] =~ /[a-zA-Z]/) {
	    push @out, pop @let;
	} else {
	    push @out, $l[$i];
	}
    }
    
    say "Output: ", join "", @out;
}
my $str = "p-er?l";
proc($str);
$str = "wee-k!L-y";
proc($str);
$str = "_c-!h_all-en!g_e";
proc($str);

