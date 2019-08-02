#!perl

################################################################################
=comment

Perl Weekly Challenge 018
=========================

Task #1
-------

Write a script that takes 2 or more strings as command line parameters and print
the longest common substring. For example, the longest common substring of the
strings "ABABC", "BABCA" and "ABCBA" is string "ABC" of length 3. Other common
substrings are "A", "AB", "B", "BA", "BC" and "C". Please check this
[ https://en.wikipedia.org/wiki/Longest_common_substring_problem |wiki page] for
details.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Set::Scalar;

const my $USAGE => "\nUSAGE: perl $0 <string-1> <string-2> [ <string-3..n> ]\n";

MAIN:
{
    @ARGV >= 2 or die $USAGE;

    my   @sets;
    push @sets, get_substrings($_) for (@ARGV);

    # The set of common substrings is the intersection of all the substring sets

    my $common_substrings = $sets[0];
       $common_substrings = $common_substrings * $sets[$_] for 1 .. $#sets;

    if ($common_substrings->is_empty)
    {
        print  "\nNo common substrings found\n";
    }
    elsif (scalar (my @solutions = get_solutions($common_substrings)) == 1)
    {
        printf "\nThe longest common substring is: \"%s\"\n", $solutions[0];
    }
    else
    {
        printf "\nThe %d longest common substrings are: %s\n",
                scalar @solutions, join(', ', map { qq["$_"] } sort @solutions);
    }
}

sub get_substrings
{
    my ($string)    = @_;
    my  $substrings = Set::Scalar->new;
    my  $max_index  = length($string) - 1;

    for my $start_index (0 .. $max_index)
    {
        for my $length (1 .. $max_index - $start_index + 1)
        {
            $substrings->insert(substr $string, $start_index, $length);
        }
    }

    return $substrings;
}

sub get_solutions
{
    my ($substrings) = @_;
    my  @sorted      = sort { length $b <=> length $a } $substrings->elements;
    my  @solutions   = shift  @sorted;
    my  $max_length  = length $solutions[0];

    while (my $element = shift @sorted)
    {
        if (length($element) == $max_length)
        {
            push @solutions, $element;
        }
        else
        {
            last;
        }
    }

    return @solutions;
}

################################################################################
