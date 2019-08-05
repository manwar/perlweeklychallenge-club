#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: Task #2
#
#  Task #2
#  Write a script that can wrap the given paragraph at a specified column using the [greedy
#  algorithm](https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap#Minimum_number_of_lines).
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch,
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 07/29/2019 08:48:27 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw{ say };

###### MAIN ######
my ( $width, @words ) = @ARGV;

$width or die 'Usage: script width text';
@words or die 'Usage: script width text';

die 'Usage: script width(numeric!) text' unless $width =~ /\d+/msx;

my $space_left = $width;

for my $word (@words) {
    my $len = length($word);

    if ( $len + 1 > $space_left ) {
        print "\n";
        $space_left = $width - $len;
    }
    else {
        $space_left -= $len;
    }

    print "$word ";
}

say qq//;
###### TESTS ######

use Test::More;

say 'NO TESTS THIS TIME';
done_testing;
