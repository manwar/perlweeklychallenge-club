use v5.30;
my $s = "Raku";
my $s2 = "Julia";
my $s3 = "Perl";
my $s4 = "Uiua";
proc($s);proc($s2);proc($s3);proc($s4);

sub proc() {
    my $s = shift;
    say "Input: \$s = $s";
    print "Output: ";
    my (@vowels, @ind);
    my @l = split "", $s;
    foreach my $i (0 .. $#l) {
	if ($l[$i] =~ /[aeiouAEIOU]/) {
	   push @vowels, $l[$i];
	   push @ind, $i;
	}
    }
    @vowels = reverse @vowels;
    my $j = 0;
    foreach my $i (0 .. $#l) {
	if ($i ~~ @ind) {
	   print $vowels[$j];
	   $j++;
	} else {
	   print $l[$i];
	}
    }
    print "\n";
}