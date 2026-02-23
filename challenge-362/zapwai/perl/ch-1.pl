use v5.38;

sub proc($str) {
    say "Input: \$str = $str";
    my @l = split '', $str;
    print "Output: ";
    for my $i (0 .. $#l) {
	print $l[$i] x ($i + 1);
    }
    print "\n";
}

my $str = "abca";
proc($str);
$str = "xyz";
proc($str);
$str = "code";
proc($str);
$str = "hello";
proc($str);
$str = "a";
proc($str);
