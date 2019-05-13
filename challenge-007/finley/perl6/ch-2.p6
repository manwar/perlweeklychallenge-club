use v6.d;

say 'Challenge 2';
my $startWord = 'stone';
my $endWord   = 'money';
my $wordFile = '/usr/share/dict/british-english';
say "The word '$startWord' can be transformed letter by letter to make '$endWord' transitioning through proper words along the way";


my $ladder = FindLadder($startWord, $endWord, $wordFile);
say $ladder.elems ?? join(' ⇒ ', |$ladder) !! 'no solution';

sub FindLadder (Str $startWord, Str $endWord, Str $wordFile)
{
    #Hat off to Dijkstra
    return [] if $startWord.chars != $endWord.chars;
    say 'loading words...';
    my %words = $wordFile.IO.slurp.lines.map(
    	#lowercase the words, and filter out non ascii words
    	{.lc}).grep({/^ <[ a .. z ]>+ $/}).grep(
    	#filter out words of the wrong length
    	{.chars == $startWord.chars}).map(
    	#and produce an 'uninitialised' structure per word
    	{$_ => {distance => Inf, path => [], seen => 0}});
    say 'loaded.';

    #the start and end words should actually be words
    return [] unless %words{$startWord};
    return [] unless %words{$endWord};

    #initialise our starting word, mark it as seen
    %words{$startWord} = {distance => 0, path => [$startWord], seen => 1};

    sub FindRungs (Str $startWord)
    {
    	my %rungWords;
    	my @breakdown = $startWord.comb;
    	loop (my $i = 0; $i < @breakdown.elems; $i++)
    	{
    		#we're going to move through the word position by position
    		#we could probably do this with splice timtowtdi
    		my ($pre, $j, $post, $k) = ('', 0, '', $i + 1);
    		$pre ~= @breakdown[$j++] while $j < $i;
    		$post ~= @breakdown[$k++] while defined @breakdown[$k];
    		for ('a' .. 'z')
    		{
    			#and test if the generated words $pre(a..z)$post exists for position $i
    			my $thisWord = $pre ~ $_ ~ $post;
    			%rungWords{$thisWord} = 1 if %words{$thisWord};
    		}
    	}
    	return [keys %rungWords];
    }

    #initialise the first round of found word-rungs
    for |FindRungs($startWord) -> $word {
    	%words{$word}<distance> = 1;
    	%words{$word}<path> = [$startWord, $word]
    }

    loop {
    	#looping, find the next batch of words from the epicenter
    	my @thisRound = %words.keys.grep(
    		#interested in unseen (unprocessed) words
    		{(!%words{$_}<seen>) && (%words{$_}<distance> != Inf)}).sort(
    		#we'll process the words closer to the epicenter (startWord) earlier
    		{%words{$^a}<distance> <=> %words{$^b}<distance>});
    	last unless @thisRound.elems;  # see * below
    	for @thisRound -> $thisWord {
    		#and initialise them too,
    		#or update as closer to the start word if they are
    		for |FindRungs($thisWord) -> $word {
    			if (%words{$word}<distance> >= %words{$thisWord}<distance> + 1)
    			{
    				%words{$word}<distance> = %words{$thisWord}<distance> + 1;
    				%words{$word}<path> = [|(%words{$thisWord}<path>), $word];
    			}
    		}
    		#we don't want to do this word again, it's been processed
    		%words{$thisWord}<seen> = 1;
    	}
    	#loop ends when we find the endword, or earlier (*) if there was no solution
    	last if $endWord ~~ @thisRound;
    }

    return %words{$endWord}<path>;
}



