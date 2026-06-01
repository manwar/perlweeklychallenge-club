use v6;

sub proc($str) {
    my $printstr = $str;
    $printstr ~~ s/\n/\\n/;
    say "Input: \$str = \"$printstr\"";
    my @words = $str.words;
    my @strip_words;
    for @words -> $word {
	my $myword = $word;
	$myword ~~ s/'<'\w+'>'(\w+)'</'\w+'>'/$0/;
	push @strip_words, lc $myword;
    }
    my $sentence = @strip_words.join(" ");
    $sentence ~~ s/<|w>(\w+)\s+$0<|w>/[$0] [$0]/;
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
