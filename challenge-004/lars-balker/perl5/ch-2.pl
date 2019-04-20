# You are given a file containing a list of words (case insensitive 1
# word per line) and a list of letters. Print each word from the file
# than can be made using only letters from the list. You can use each
# letter only once (though there can be duplicates and you can use
# each of them once), you don’t have to use all the
# letters. (Disclaimer: The challenge was proposed by Scimon Proctor)
use v5.20;
use strict;
use warnings;

# accept file as first arg, rest of args are letters, ignoring spacing and case

my $file = shift;
my %letters;
$letters{$_}++ for map { split //, lc } @ARGV;

die "$0 <file with list of words> <list of letters>\n" unless $file and %letters;

open my $f, "<", $file or die "no such file: $file\n";

WORD: while (my $word = <$f>) {
	chomp $word;
	my %temp = %letters;
	for my $c (split //, lc $word) {
		next WORD unless $temp{$c}--;
	}
	say $word;
}
