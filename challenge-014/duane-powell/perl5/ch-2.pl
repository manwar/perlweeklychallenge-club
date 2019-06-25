#!/usr/bin/env perl
use Modern::Perl;

#https://perlweeklychallenge.org/blog/perl-weekly-challenge-014/
#Using only the official postal (2-letter) abbreviations for the 50 U.S. states, write a script to find the longest 
#English word you can spell? Here is the list of U.S. states abbreviations as per wikipedia page. 
#This challenge was proposed by team member Neil Bowers.

my @state_abbv = qw(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY);
my %states = map {$_ => 1} @state_abbv; #create lookup table of state abbv

#words.txt is all English words, thanks to JoeChen2 https://github.com/dwyl/english-words/blob/master/words.txt
open(my $fh, "<", "words.txt") or die "Can't open < words.txt: $!";

my $longest_word = ""; 
while (my $word = <$fh>) {
	chomp $word;
	next if (length($word) % 2 == 1); #must be even length word
	$word = uc($word); #convert to upper case, same case as state abbreviations
	my @char_pairs = ( $word =~ m/(..)/g ); #split into array by every 2 chars

	my $all_match = 0; #if we match all 2 char pairs with a state abbv the word is a candidate for longest
	foreach my $abbv (@char_pairs) {
		$all_match = $states{$abbv};
		last unless ($all_match);
	}
	if ($all_match) {
		$longest_word = $word if (length($word) >= length($longest_word)); #if there is tie for longest the last word wins
		say "$word, $longest_word";

	}
}

__END__

./ch2.pl 
AK, AK
AKAL, AKAL
AKAZGA, AKAZGA
...
ALKY, ALCAVALA
ALKYLAMINE, ALKYLAMINE
ALKYNE, ALKYLAMINE
ALLA, ALKYLAMINE
ALLAIN, ALKYLAMINE
...
WINY, CACOGALACTIA
WISC, CACOGALACTIA
WISD, CACOGALACTIA
WIWI, CACOGALACTIA
WV, CACOGALACTIA

