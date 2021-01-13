#!/usr/bin/perl;
use strict;
use warnings;

sub is_anagram {
	my ($word1, $word2) = @_;

	my $sorted1 = join q{}, sort split(q{}, lc $word1);
	my $sorted2 = join q{}, sort split(q{}, lc $word2);

	return $sorted1 eq $sorted2;
}

print "Enter a word to find anagrams for: ";
chomp(my $compare_word = <>);

print "Enter a word: ";
while (my $user_input = <>) {
	chomp $user_input;
	if (is_anagram($compare_word, $user_input)) {
		print "$user_input and $compare_word are anagrams.\n";
	}
	print "Enter a word: ";
}

__END__
