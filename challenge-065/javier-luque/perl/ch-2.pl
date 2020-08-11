#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;

say 'Solutions for: aabaab:';
for my $answer (palindrome('aabaab')) {
    say join ', ', @$answer;
};

say "\n\nSolutions for: abbaba:";
for my $answer (palindrome('abbaba')) {
    say join ', ', @$answer;
};

sub palindrome {
    my $string = shift;
    my @letters = split (//, $string);

    # All possible answers
    my @answers;

    # Divide the answers into chunks #scalar(@letters)
    for (my $i = 0; $i < scalar(@letters); $i++) {
    		my $possible_word = '';

    		# Process each chunk
    		for (my $j = $i; $j < scalar(@letters); $j++) {
    			$possible_word .= $letters[$j];

    			# Make sure the word is longer than 1 char
    			if (length($possible_word) > 1) {
    				# Check this word
    				if ($possible_word eq reverse($possible_word)) {
    					# Recusive check
    					my $sub_string = substr($string, $j + 1);
    					my @palins = palindrome($sub_string);

    					if (scalar (@palins)) {
    						for my $palin (@palins) {
    							push @answers, [ $possible_word, @$palin ] ;
    						}
    					} else {
    						push @answers,  [ $possible_word ];
    					}
    				}
    			}
    		}
    }

    return @answers;
}
