use v5.38;

sub proc($s, @k) {
    say "Input: \$s = $s, \@keys = @k";
    my @keys = map { lc } @k;
    my @words = split ' ', $s;
    my $cnt = 0;
    for my $word (@words) {
	for my $letter (@keys) {
	    if (lc($word) =~ /$letter/) {
		$cnt++;
		last;
	    }
	}
    }
    my $o = scalar(@words) - $cnt;
    say "Output: $o";
}

my $s = "Hello World";
my @keys = ('d');
proc($s, @keys);

$s = "apple banana cherry"; @keys = ('a', 'e');
proc($s, @keys);

$s = "Coding is fun"; @keys = ();
proc($s, @keys);

$s = "The Weekly Challenge"; @keys = ('a', 'b');
proc($s, @keys);

$s = "Perl and Python"; @keys = ('p');
proc($s, @keys);
