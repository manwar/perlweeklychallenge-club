use v5.30;
my @list = ("Perl and Raku belong to the same family.",
	    "I love Perl.",
	    "The Perl and Raku Conference.");
my $max = 0;
for my $sent (@list) {
    my @L = split(" ", $sent);
    my $c = @L;
    $max = $c if ($c > $max);
}
say "Input: \@list = @list";
say "Output: $max";
