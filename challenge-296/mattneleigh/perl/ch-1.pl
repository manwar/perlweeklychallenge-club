#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    "abbc",
    "aaabccc",
    "abcc",

    # Additional test cases
    "aaaaabcdddddeeeeeeeeeeeee"
);

print("\n");
foreach my $string (@strings){
    my $compressed = rle_compress_string($string);

    printf(
        "Input: \$chars = \"%s\"\nOutput: \"%s\"\nDecompressed:   \"%s\"\n\n",
        $string,
        $compressed,
        rle_decompress_string($compressed)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting only of alphabetic characters ("letters"), compress
# it using a form of run-length encoding (RLE) in which repeated characaters
# are replaced with a number prefix indicating how many times said character
# repeats
# Takes one argument:
# * The string to examine (e.g. "aaaaabcdddddeeeeeeeeeeeee" )
# Returns:
# * The compressed form of the string (e.g. "5abc5d13e" )
################################################################################
sub rle_compress_string{
    my $str = shift();

    my $maxlen = length($str);
    my $len;
    my $compressed = "";

    while(1){
        # Identify the next block of identical
        # characters
        $str =~ m/((.)\2*)/g;

        # Determine the block's length
        $len = length($1);

        # Add the character from the block as
        # appropriate- with a repeat prefix if
        # there was more than one
        $compressed .= ($len > 1 ? $len : "") . $2;

        # Break the loop unless we've still got
        # string to examine
        last
            unless(pos($str) < $maxlen);
    }

    return($compressed);

}



################################################################################
# Decompress a RLE-compressed string of the type produced by
# rle_decompress_string() (see documentation above)
# Takes one argument:
# * A RLE-compressed string (e.g. "5abc5d13e" )
# Returns:
# * The decompressed string (e.g. "aaaaabcdddddeeeeeeeeeeeee" )
################################################################################
sub rle_decompress_string{
    my $compressed = shift();

    my $maxlen = length($compressed);
    my $decompressed = "";

    while(1){
        # Extract the next non-digit character
        # OR a number and the subsequent non-
        # digit character
        $compressed =~ m/(?|(\D)|(\d+)(\D))/g;

        if(defined($2)){
            # $2 was defined- this was a number and
            # non-digit sequence
            $decompressed .= $2 x $1;
        } else{
            # Just a non-digit character
            $decompressed .= $1;
        }

        # Break the loop unless we've still got
        # string to examine
        last
            unless(pos($compressed) < $maxlen);
    }

    return($decompressed);

}



