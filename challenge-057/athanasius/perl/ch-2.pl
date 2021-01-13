#!perl

################################################################################
=comment

Perl Weekly Challenge 057
=========================

Task #2
-------
*Shortest Unique Prefix*

Write a script to find the *shortest unique prefix* for each word in the given
list. The prefixes will not necessarily be of the same length.

*Sample Input*

    [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]

*Expected Output*

    [ "alph", "b", "car", "cadm", "cade", "alpi" ]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use List::Util qw( max );
use lib '.';
use Trie;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 057, Task #2: Shortest Unique Prefix (Perl)\n\n";

    my @words = qw( alphabet book carpet cadmium cadeau alpine );
    my $width = max map { length } @words;

    # Create a trie tree of the words, and a hash mapping each word to its last
    # node in the trie

    my $trie = Trie->new();
    my %word_ends;

    $word_ends{$_} = $trie->insert_word($_) for @words;

    # Find and print the shortest unique prefix for each word

    for my $word (@words)
    {
        my ($prefix, $last_letter);
        my  $in_prefix = 0;

        for (my $node = $word_ends{$word}; $node; $node = $node->get_parent)
        {
            if ($in_prefix)
            {
                $prefix      = $node->get_letter . $prefix;
            }
            elsif ($node->num_children > 1)
            {
                $prefix      = $node->get_letter . $last_letter;
                $in_prefix   = 1;
            }
            else
            {
                $last_letter = $node->get_letter;
            }
        }

        printf "%-*s --> %s\n", $width, $word, $prefix;
    }
}

################################################################################
