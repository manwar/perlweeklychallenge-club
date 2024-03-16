use v5.30.0;
my $allow = 'eiufhkljwodkg';
open fh, "<", "words" or die 'no file?';
my @word = <fh>;
close fh;
word: foreach my $word (@word) {
    chomp $word;
    my $WORD = $word;
    my $allow = $allow;		# local copy
    my $cnt = 0;
    for my $i (0 .. -1 + length $word) {
	my $letter = substr $word, $i, 1;
	if ($allow =~ $letter) {
	    $cnt++;
	}
    }

    if ($cnt < length $word) {
	next word;
    } else {
	my $index = 0;
	do {
	    my $let = substr $allow, $index, 1;
	    if ($word =~ /$let/) {
		$allow =~ s/$let//;
		$word =~ s/$let//;
	    } else {
		$index++
	    }
	} while ($index < length $allow);
    }    
    say "$WORD" unless ($word);
}
