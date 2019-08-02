#!/usr/bin/env perl
#
use warnings;
use strict;
use FindBin;
my $wordsFile= $FindBin::Bin."/../words_alpha.txt";
open my $wfh, "<" , $wordsFile;
my @words;
while (<$wfh>) {
	chomp;
	push @words, $_;
}
close $wfh;

sub findAnagrams {
	my $word=shift;
	my $ref=shift;
	my @words=@$ref;;
	my @a=sort(split('', lc $word));

	my @anagrams;
	my $test;
	while (1){
		$test=join '',@a;
		#print "$test\n";
		my @res=grep {$_ eq $test} @words;

		push @anagrams, @res;
		my $k=0;
		my $l=0;
		my $maxK=-1;
		my $maxL=-1;
		while ($k < $#a) {
			$maxK= $k if (($a[$k] lt $a[$k+1]) && ($k > $maxK));
			$k++;
		}
		last unless $maxK >= 0;
		$maxL=$maxK+1;
		while ($l <= $#a) {
			$maxL= $l if (($a[$maxK] lt $a[$l]) && ($l > $maxL));
			$l++;
		}
		my $tmp=$a[$maxK];
		$a[$maxK]=$a[$maxL];
		$a[$maxL]=$tmp;
		my @b= reverse(splice @a, $maxK+1);
		push @a, @b;
	}

	return @anagrams;
}

my $word=$ARGV[0];
my @anagrams=findAnagrams($word, \@words);
print "Anagrams: @anagrams ","\n";
