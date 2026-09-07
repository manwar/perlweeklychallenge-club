use v5.38;

sub proc($s) {
    say "Input: $s";
    my $cnt = 0;
    while ($s =~ /01/) {
	$cnt++;
	$s =~ s/01/10/g;
    }
    say "Output: $cnt";
}

my $s = "111000";
proc($s);
$s = "00011";
proc($s);
$s = "01011";
proc($s);
$s = "010101";
proc($s);
$s = "00001";
proc($s);
