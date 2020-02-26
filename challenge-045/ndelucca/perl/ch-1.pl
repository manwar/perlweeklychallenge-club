#!/usr/bin/perl

# Square Secret Code

# The squate secret code mechanism first removes any space from the original message.
# Then it lays down the message in a row of 8 columns.
# The coded message is then obtained by reading down the columns going left to right.

# For example, the message is “The quick brown fox jumps over the lazy dog”.

# Then the message would be laid out as below:

# thequick
# brownfox
# jumpsove
# rthelazy
# dog

# The code message would be as below:

# tbjrd hruto eomhg qwpe unsl ifoa covz kxey

# Write a script that accepts a message from command line and prints the equivalent coded message.

use strict;
use warnings;

die "You must insert a message to encode.\n" unless @ARGV;

my $message = shift;
my $columns = shift || 8;

my @matrix = ();
my $code = '';

# We clean up the message a bit
$message =~ s/\s+//g;

# Then we must turn the message into an array of arrays
my @rows = unpack "(A$columns)*", lc $message;

foreach my $word ( @rows ){
    my @chars = split //, $word;
    push @matrix, \@chars;
}

# Now we simply print it in the order we want
for (0..$columns){

    for my $row( @matrix ){
        $code .= shift @$row || '';
    }

    $code .= " ";
}

print "$code\n";

# perl ch-1.pl "The quick brown fox jumps over the lazy dog"
# tbjrd hruto eomhg qwpe unsl ifoa covz kxey

# perl ch-1.pl "The quick brown fox jumps over the lazy dog" 15
# txz hjy eud qmo upg is co kv be rr ot wh ne fl oa

# perl ch-1.pl "Maybe this code could be better?"
# msle acdr yob? bde eeb tce hot iut

