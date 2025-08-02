use v5.38;
my $sent = "I love Perl";
proc($sent);
$sent = "Perl and Raku are friends";
proc($sent);
$sent = "The Weekly Challenge";
proc($sent);

sub proc($sent) {
    say "Input: $sent";
    print "Output: ";
    my @words = split(" ", $sent);
    for my $i (0 .. $#words) {
	my $A = "a" x ($i + 1);
	my @lets = split("", $words[$i]);
	my $first_let = $lets[0];
	shift @lets;
	my $reword = join "", @lets;
	$reword .= $first_let;
	if ($first_let =~ /[aeiouAEIOU]/) {
	    print $words[$i]."ma".$A." ";
	} else {
	    print $reword."ma".$A." ";
	}
    }
    print "\n";
}
