use v5.30.0;
my @words = ('abc', 'xyz', 'cab');
my $count = 0;
my $output;
say "Input: \@words = @words";
print "Output: ";
is_alph($_) foreach (@words);
say $count;
say $output . "can be removed." if ($output);
sub is_alph {
    my $word = shift;
    my @let = split("",$word);
    foreach (0 .. $#let - 1) {
	if ($let[$_] gt $let[$_ + 1]) {
	    $count++ ;
	    $output .= $word . " ";
	}
    }
}
