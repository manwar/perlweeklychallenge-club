# You are given a file containing a list of words (case insensitive 1 word per line) 
# and a list of letters. Print each word from the file that can be made using only 
# letters from the list. You can use each letter only once (though there can be duplicates and you can use each of them once),
# you don’t have to use all the letters. (Disclaimer: The challenge was proposed by Scimon Proctor)

use strict;
use warnings;
use 5.010;

die "Usage:\n\tch-2.pl <file> <letters>\n\n\t<file>\t\t- file containing 1 word perline\n\t<letters>\t- letters to search (no space)\n" if @ARGV<2;

my $filename = shift @ARGV;
my @letters = shift =~/./g;

open(my $fh, '<', $filename)
    or die "Could not open file '$filename' $!";
 
while (my $row = <$fh>) {
    chomp $row;
    my $hold = $row;
    $row=~s/$_// for @letters;
    say $hold if !$row
}