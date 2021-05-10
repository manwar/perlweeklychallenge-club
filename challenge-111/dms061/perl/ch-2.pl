use strict;
use warnings;

# Question 2: Given a word, you can sort its letters alphabetically (case insensitive). 
# For example, “beekeeper” becomes “beeeeekpr” and “dictionary” becomes “acdiinorty”.

# Write a script to find the longest English words that don’t change when their letters are sorted.

# The question is trying to be misleading. If the word doesn't change when it is sorted, then 
# all we have to check is if the word is sorted (no need to reverse it)

open(my $dict, "<", "american-english") or die "Couldn't open dict file\n";

my @chars;
my $len = 0;
my @words;
WORD: while (<$dict>) {
	# Remove whitespace (chomp), convert to lowercase ('A' != 'a') and split word into an array of characters 
	chomp;
	$_ = lc;
	# Implementation is based off the idea that the string need only be iterated over once
	# Because we have to split it, we really iterate over it twice
	# A more efficient implementation would just access characters in the string directly
	@chars = split "";
	# Optimization, only search for words of increasing size
	next WORD if @chars < $len;
	# Check if the word is sorted
	for(my $i = 0; $i < $#chars; $i++){
		# like a weird mix of break and goto
		# immediately goes to the next iteration of the label
		# no other code is executed
		next WORD unless $chars[$i] le $chars[$i+1];
	}
	#print "$_\n";
	if ($len == @chars){
		#equal length, add to a list
		push @words, $_;
	}else{
		# new largest (remember we skip smaller words)
		#reset the list and update the length
		@words = ($_);
		$len = @chars;
	}
}

print "Question 2:\nLongest presorted word(s) in American English is/are $len letters long.\nWord(s): @words\n";

#open(my $dict, "<", "/usr/share/dict/american-english");
close $dict;

