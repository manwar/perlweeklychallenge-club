use strict;
use warnings;
##
# Write a script to print  the nucleiobase count in
# the given DNA sequence. Also print the complementary 
# sequence where Thymine (T) on one strand is always 
# facing an adenine (A) and vice versa; guanine (G) is 
# always facing a cytosine (C) and vice versa.
##
use constant SEQUENCE => "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";
my %nucleotide_map = (
    "T" => "A", 
    "A" => "T", 
    "G" => "C", 
    "C" => "G" 
);    

sub complementary_sequence{
    my($sequence) = @_;
    my @complement = map { $nucleotide_map{$_} } split(//, $sequence);
    return @complement; 
} 

MAIN:{
    print "length of sequence: " . length(SEQUENCE) . "\n";
    print "complementary sequence: " . join("", complementary_sequence(SEQUENCE)) . "\n";      
} 
