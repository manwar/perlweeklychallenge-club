#!/usr/bin/perl

use v5.10;
use strict;
use warnings;

#	PART 2
use Data::Dumper;
my $letterSet = "arefileYOu";			#letter set to be matched to
print "Given letter Set:: $letterSet\n";
$letterSet = lc $letterSet;
my %letterFreq = buildFreq($letterSet);
#print Dumper(\%letterFreq);

open(FH,'<','inputFile') or die($!);	# file containing list of words
while(my $word = <FH>){
	chomp $word;
	$word = lc $word;
	my $status = wordMatch(\%letterFreq,$word)? "matched":"not matched";
	print "$word ==> $status\n"
}

sub wordMatch{
	# arg : <hash> <string>
	my %letterFreq = %{$_[0]};
	my $word = $_[1];
	my %wordFreq = buildFreq($word);
	#print Dumper(\%wordFreq);
	
	for my $key (keys %wordFreq){
		unless( exists $letterFreq{$key} and $wordFreq{$key} <= $letterFreq{$key} ){
			return 0;
		}
	}
	return 1;
}



sub buildFreq{	#given a string returns letter freq. hash
	my $var = shift;
	my %freq;
	for my $key (split //, $var){
		$freq{$key}++;
	}
	return %freq;
}


# ------------- version 2 -----------------------
# -----------------------------------------------
sub checkWord {
    my ($word,$letters) = @_;
    $word = join '\w*', sort split //, lc $word;
    $letters = join "", sort split //, lc $letters;
    my $pattern = $word;
    if( $letters =~ /$pattern/ ){
        return 1;
    }else{
        return 0;
    }
}

my $letters = 'aabceilttxyz';
open(FH, "inputFile") or die "open inputFile:: $!";
for my $word (<FH>) {
    chop $word;
    if( checkWord($word, $letters) ){
        say "valid: $word";
    }else{
        say "not valid: $word"
    }
}
