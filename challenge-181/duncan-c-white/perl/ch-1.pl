#!/usr/bin/perl
# 
# Task 1: Sentence Order
# 
# You are given a paragraph.
# 
# Write a script to order each sentence alphanumerically and print the
# whole paragraph.
# 
# Example
# 
# Input:
#     All he could think about was how it would all end. There was
#     still a bit of uncertainty in the equation, but the basics
#     were there for anyone to see. No matter how much he tried to
#     see the positive, it wasn't anywhere to be seen. The end was
#     coming and it wasn't going to be pretty.
# 
# Output:
#     about All all could end he how it think was would. a anyone
#     basics bit but equation, for in of see still the the There
#     there to uncertainty was were. anywhere be he how it matter
#     much No positive, see seen the to to tried wasn't. and be
#     coming end going it pretty The to was wasn't.
# 
# MY NOTES: hmm, sounds surprisingly tricky, we have to read all the input,
# identify all the sentences (a sentence can span multiple lines), for each
# sentence split off the trailing '. ', sort the words in the sentence in
# case-insensitive order, add the '. ' back again, accumulate all the
# output words in a single array, and then print it out with width formatting.
# Stole width formatting code from challenge 177.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


#
# my $sortsent = sort_sentence($sentence);
#	Sort the words in a given sentence, return the sorted sentence.
#
sub sort_sentence
{
	my( $sentence ) = @_;
	my @word = split( /\s+/, $sentence );
	@word = sort { lc($a) cmp lc($b) } @word;
	return join( ' ', @word );
}


my $debug=0;
die "Usage: sentence-order [--debug] < input\n"
	unless GetOptions( "debug"=>\$debug );

# read all the input into a single long line.
my @input;
while( $_ = <> )
{
	chomp;
	s/^\s+//;
	s/\s+$//;
	push @input, $_;
}
my $input = join( ' ', @input );

# now split into sentences
my @sentence;
while( $input =~ s/^([^.]+)\.\s?// )
{
	say "S:$1" if $debug;
	push @sentence, $1;
}
if( $input )
{
	say "S:$input" if $debug;
	push @sentence, $input;
}

my $str = join( ' ', map { sort_sentence($_) } @sentence ) . '.';

# format $str with lines <= maxw chars long.
my $maxw = 62;
while( length($str) >= $maxw )
{
        my $pos;
        for( $pos=$maxw; $pos>0 && substr($str,$pos,1) ne ' '; $pos-- )
        {
        }
        say substr($str,0,$pos);
        $str = substr($str,$pos+1);
}
say $str;
