#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: Task #1
#
#    Write a script to accept a string from command line and split it on change of character. For example, if the string is “ABBCDEEF”, then it should split like “A”, “BB”, “C”, “D”, “EE”, “F”.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch,
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 08/05/2019 08:48:27 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw{ say };
use Carp;

sub split_str {
    my $input = shift;

    # remember the previous character
    my $previous_char;

    # store the end result
    my $result;

    # process all characters in the string
    for my $char ( split //msx, $input ) {

        # if the current char is different than previous, let's split
        $result .= "\n" if ($previous_char) and ( $char ne $previous_char );

        # add current char to result
        $result .= $char;

        # let's remember the current character
        $previous_char = $char;

    }

    return $result;
}

###### MAIN ######

my $input = shift or croak 'Usage: script string';

say split_str($input);

###### TESTS ######

use Test::More;

say 'TESTS:';

# test the sample
like( split_str('ABBCDEEF'), qr/A\nBB\nC\nD\nEE\nF/msx, 'test ABBCDEEF' );
unlike( split_str('ABBCDEEF'), qr/A\nBB\nC\nD\nEE\nAF/msx, 'test wrong ABBCDEEF' );

# two chars at the beginning
like( split_str('AABBCDEEF'), qr/AA\nBB\nC\nD\nEE\nF/msx, 'test AABBCDEEF' );
unlike( split_str('AABBCDEEF'), qr/AA\nBB\nC\nD\nEE\nAF/msx, 'test wrong AABBCDEEF' );

# two chars at the end
like( split_str('ABBCDEEFF'), qr/A\nBB\nC\nD\nEE\nFF/msx, 'test ABBCDEEFF' );
unlike( split_str('ABBCDEEFF'), qr/A\nBB\nC\nD\nEE\nAFF/msx, 'test wrong ABBCDEEFF' );

done_testing;
