use v5.38;
sub proc($word, @array) {
    say "Input: \$word = $word, \@array = @array";
    my $myword;
    foreach my $w (@array) {
	$myword .= substr $w, 0, 1;
    }
    say "Output: ", ($myword eq $word) ? "true" : "false";
}

my @array = ("Perl", "Weekly", "Challenge");
my $word  = "PWC";
proc($word, @array);

@array = ("Bob", "Charlie", "Joe");
$word = "BCJ";
proc($word, @array);
@array = ("Morning", "Good");
$word = "MM";
proc($word, @array);
