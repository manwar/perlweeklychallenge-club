#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $fh;
my @words;

# Open ourself, or halt with an error
open($fh, "<", $PROGRAM_NAME)
    or die("E: Could not open myself: $!\n");

# Read every line
while(<$fh>){
    # Strip line terminators
    chomp;

    # Add the whitespace-separated words to the
    # list of words
    push(@words, split(" ", $_));
}

close($fh);

# Select a word at random and print it
print($words[int(rand(scalar(@words)))], "\n");

exit(0);
################################################################################
# End main execution
################################################################################



