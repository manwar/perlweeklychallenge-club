#!/usr/bin/perl

use strict;
use warnings;

#	PART 2
use Data::Dumper;
my %anaCount;
my @wordList = ('abc','aabb','aedccc','aabbcc');

my @max = (0,'');
for my $word (@wordList){
	my %dict;
	++$dict{$_} for split('', $word);
	#print Dumper(\%dict);
	my $deno = 1;
	$deno *= factorial($_) for values %dict;
	my $result = int factorial(length($word)) / $deno;
	@max = ($result,$word) if $result> $max[0];
}
print "word with max anagrams:\n";
print "@max\n";
sub factorial {
    my ($n) = @_;
	$n *= $_ for 2 .. $n - 1;
	return $n
}

