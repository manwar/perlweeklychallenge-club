#!/usr/bin/env perl
my @letters;
my %letters;
my @words;
open(my  $lettersFile ,"<",(shift));
while (<$lettersFile>) {
	chomp;
	s/\W//g;
	$letters{$_}++ foreach ( split "");
}
close $lettersFile;

open(my $wordsFile, "<", (shift));
my %words;
while (<$wordsFile>) {
	chomp;
	s/\W//gr;
	my %bag;
	$bag{$_}++ foreach (split "");

	#now actually compare line by line
	my $all=1;
	foreach (keys %bag) {
		$all &&= $letters{$_} >= $bag{$_};
		last if not $all;
	}
	print "$_\n" if $all;

}
close $wordsFile;
