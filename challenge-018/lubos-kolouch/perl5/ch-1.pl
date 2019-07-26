#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: Task #1
#
#    Write a script that takes 2 or more strings as command line parameters and print the longest common substring. For example, the longest common substring of the strings “ABABC”, “BABCA” and “ABCBA” is string “ABC” of length 3. Other common substrings are “A”, “AB”, “B”, “BA”, “BC” and “C”. Please check this wiki page for details.
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch,
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 07/24/2019 08:48:27 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw{ say };
use Data::Dumper;

my %all_strings;
my $max_count = 0;

# ignore substrings 
my $seen_first;

sub insert_to_all_strings {
    my $str = shift;

    my %seen_str;

    my $length = length($str);

    for my $pos ( 0 .. $length - 1 ) {
        for my $length_remain ( 1 .. $length - $pos ) {
            my $sub_string = substr( $str, $pos, $length_remain );

            # skip if this substring is not present in the first word
            next if $seen_first and not defined $all_strings{length($sub_string)}{$sub_string};

            # skip if the string was already present in the current letter
            next if $seen_str{$sub_string};

            # remember we have already seen the letter
            $seen_str{$sub_string} = 1;

            my $current_count = $all_strings{$sub_string} // 0;
            $current_count++;

            # We have seen the substring one more time
            $max_count = $current_count if $current_count > $max_count;

            # Let us remember it
            $all_strings{ length($sub_string) }{$sub_string}++;
        }

    }

    $seen_first = 1;

    return 1;
}

sub longest_str {
    my @strings = @_;

    my $found_solution;

    # fill in all the common strings and their count
    insert_to_all_strings($_) for (@strings);

    # print the longest one

    foreach my $str_length ( sort { $b <=> $a } keys %all_strings ) {

        foreach my $string ( keys %{ $all_strings{$str_length} } ) {
            if ( $all_strings{$str_length}{$string} == scalar @strings ) {

                # we found a substring that is in all strings
                say "Common string $string";
                $found_solution = $string;
            }
        }

        last if $found_solution;
    }

    say 'No common string found' unless $found_solution;
    return $found_solution;

}

###### MAIN ######

my @strings = @ARGV or die 'Usage: script string1 string2 stringN';
die 'Usage: script string1 string2 stringN' unless @strings >= 2;

longest_str(@strings);

###### TESTS ######

use Test::More;

say 'TESTS:';
%all_strings = ();
$seen_first = 0;
is( longest_str( 'ABABC', 'BABCA', 'ABCBA' ), 'ABC', 'Test 1' );

done_testing;
