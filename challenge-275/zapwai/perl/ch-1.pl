use v5.38;
my $sentence = "Perl Weekly Challenge";
my @keys = ('l', 'a');
proc($sentence, @keys);
$sentence = "Perl and Raku"; @keys = ('a');
proc($sentence, @keys);
$sentence = "Well done Team PWC"; @keys = ('l', 'o');
proc($sentence, @keys);
sub proc($sentence, @keys) {
    say "Input: Sentence = $sentence, keys = @keys";
    my $num = 0;
  word:    foreach my $word (split " ", $sentence) {
	foreach my $key (@keys) {
	    next word if ($word =~ /$key/);
	}
	$num++;
    }
    say "Output: $num";
}
    
