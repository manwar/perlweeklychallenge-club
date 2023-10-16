use v5.30;
my @arr1 = ("ab","c");
my @arr2 = ("a","bc");
say "Input:\t \@arr1 = (". join(", ", @arr1) . ")";
say "\t \@arr2 = (" . join(", ", @arr2) . ")";
my $veracity = (paste(@arr1) eq paste(@arr2)) ? "True" : "False";
say "Output: " . $veracity;
sub paste {
    my @a = @_;
    my $word;
    for (0 .. $#a) {
	$word .= $a[$_];
    }
    $word
}
