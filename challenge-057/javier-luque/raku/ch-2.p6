# Test: perl6 ch-2.p6 4
use Concurrent::Trie;

sub MAIN() {
    my $trie = Concurrent::Trie.new;
    my @words = qw[
    	alphabet  book    carpet
    	cadmium   cadeau  alpine
    ];

    # Insert each word
    for (@words) -> $word {
    	$trie.insert($word)
    }

    # Find each answer
    my @answers;
    for (@words) -> $word {
    	my $search_word = '';

    	for ($word.comb) -> $letter {
    		$search_word ~= $letter;
    		my @counts = $trie.entries($search_word);

    		# If there is only one word left,
    		# we are unique
    		if (@counts.elems == 1) {
    			@answers.push($search_word);
    			last;
    		}
    	}
    }

    say @answers.perl;
}
