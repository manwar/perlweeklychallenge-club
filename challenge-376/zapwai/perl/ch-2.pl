use v5.38;

## strips html tags and special chars

sub proc($str) {
    my $printstr = $str;
    $printstr =~ s/\n/\\n/;
    say "Input: \$str = \"$printstr\"";
    my @words = split(" ", $str);
    my @strip_words;
    foreach my $word (@words) {
	$word =~ s/<\w+>(\w+)<\/\w+>/$1/;
	push @strip_words, lc $word;
    }
    my $sentence = join " ", @strip_words;
    $sentence =~ s/\b(\w+)\s+\1\b/[$1] [$1]/g;
    say "Output: \"$sentence\"";
}

my $str = "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible.";
proc($str);

$str = "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.";
proc($str);

$str = "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.";
proc($str);

$str = "to make a word bold: '...it is <B>very</B> very important...'.";
proc($str);

$str = "Perl officially stands for Practical Extraction and Report Language, except when it doesn't.";
proc($str);
