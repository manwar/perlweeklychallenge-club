use v5.38;

sub proc(@sentences) {
    say "Input: ". join(", ",@sentences);
    my $max = 0;
    for my $sent (@sentences) {
	my @w = split ' ', $sent;
	my $cnt = @w;
	$max = $cnt if ($max < $cnt);
    }
    say "Output: $max";
}

my @sentences = ("Hello world", "This is a test", "Perl is great");
proc(@sentences);
@sentences = ("Single");
proc(@sentences);
@sentences = ("Short", "This sentence has six words in total", "A B C", "Just four words here");
proc(@sentences);
@sentences = ("One", "Two parts", "Three part phrase", "");
proc(@sentences);
@sentences = ("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question");
proc(@sentences);
