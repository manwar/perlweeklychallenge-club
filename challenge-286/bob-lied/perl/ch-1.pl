#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 286 Task 1 Self Spammer
#=============================================================================
# Write a program which outputs one word of its own script / source code
# at random. A word is anything between whitespace, including symbols.
# Example 1
#   If the source code contains a line such as:
#   'open my $fh, "<", "ch-1.pl" or die;'
#   then the program would output each of the words
#   { open, my, $fh,, "<",, "ch-1.pl", or, die; }
# (along with other words in the source) with some positive probability.
# Example 2
#   'print(" hello ");' is *not* an solution program, because it always
#   prints "hello" but does not assign positive probability to the other
#   two words in the script.  It will never display 'print("' or '");'
# Example 3
#   An empty script is one trivial solution, and here is another:
#   echo "42" > ch-1.pl && perl -p -e '' ch-1.pl
#=============================================================================

use v5.40;
use English qw/$PROGRAM_NAME/;
use FindBin qw/$Bin/;
use File::Spec;
use File::Slurper qw/read_text/;

# my $path = File::Spec->catfile($Bin, $PROGRAM_NAME);
# my $text = read_text($path);
# my @word = split(" ", $text);
# my $pick = int(rand(@word));
# say $word[$pick];

my @word = split(" ", read_text( File::Spec->catfile($Bin, $PROGRAM_NAME)));
say $word[ int(rand(@word)) ];
