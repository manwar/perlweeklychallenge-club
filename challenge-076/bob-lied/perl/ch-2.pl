#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 076 Task #2 > Word Search
# Write a script that takes two file names.  The first file would contain word
# search grid as shown below.  The second file contains list of words, one
# word per line.  You could even use local dictionary file.
#
# Print out a list of all words seen on the grid, looking both orthogonally
# and diagonally, backwards as well as forwards.
#=============================================================================

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib "lib";
use WordSearch;

sub Usage { "Usage: $0 [-l min-length] grid-file wordlist-file" };

my $MinLength = 5;
my $Verbose = 0;
GetOptions('length=i' => \$MinLength, "verbose!" => \$Verbose);

my $gridFile = shift;
my $wordlistFile = shift;

die Usage() unless $gridFile && $wordlistFile;
die ( Usage(). " $!" ) unless -r $gridFile;
die ( Usage(). " $!" ) unless -r $wordlistFile;

die Usage() unless ( $MinLength > 0 && $MinLength < 50 );

my $wordsearch = WordSearch->new();
$wordsearch->loadGrid($gridFile);
$wordsearch->loadWordlist($wordlistFile, $MinLength);

my $result = $wordsearch->run();

my $count = $wordsearch->numFound();
my $foundList = $wordsearch->foundList();
say "Found $count words of length $MinLength or longer";
if ( $Verbose )
{
    say "[" . ($_+1) ."] $foundList->[$_]" for 0 .. $count-1;
}
