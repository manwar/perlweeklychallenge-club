# Test: perl6 ch-2.p6
sub MAIN() {
    say 'Solutions for: aabaab:';
    for (palindrome('aabaab')) -> $answer {
    	say $answer.join(", ")
    };

    say "\n\nSolutions for: abbaba:";
    for (palindrome('abbaba')) -> $answer {
    	say $answer.join(", ");
    };
}

sub palindrome (Str $string){
    my @letters = $string.comb;

    # All possible answers
    my @answers;

    # Divide the answers into chunks #scalar(@letters)
    loop (my $i = 0; $i < @letters.elems; $i++) {
    		my $possible_word = '';

    		# Process each chunk
    		loop (my $j = $i; $j < @letters.elems; $j++) {
    			$possible_word ~= @letters[$j];

    			# Make sure the word is longer than 1 char
    			if ($possible_word.chars > 1) {

    				# Check this word
    				if ($possible_word eq $possible_word.flip) {
    					# Recusive check
    					my $sub_string = substr($string, $j + 1);
    					my @palins = palindrome($sub_string);

    					if (@palins) {
    						for (@palins) -> $palin {
    							push @answers, [ $possible_word, @$palin ] ;
    						}
    					} else {
    						@answers.push([ $possible_word ]);
    					}
    				}
    			}
    		}
    }
    return @answers;
}
