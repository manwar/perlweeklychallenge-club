#!/usr/bin/env perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-057/         #
#                                                                         #
# invert tree                                                             #
# you are given a full binary tree of any height, similar to the          #
# one below:                                                              #
#                                                                         #
#            1                                                            #
#           / \                                                           #
#          2   3                                                          #
#         / \ / \                                                         #
#        4  5 6  7                                                        #
#                                                                         #
# write a script to invert the tree, by mirroring the children of every   #
# node, from left to right. the expected output from the tree above       #
# would be:                                                               #
#                                                                         #
#            1                                                            #
#           / \                                                           #
#          3   2                                                          #
#         / \ / \                                                         #
#        7  6 5  4                                                        #
#                                                                         #
# the input can be any sensible machine-readable binary tree format of    #
# your choosing, and the output should be the same format.                #
#                                                                         #
# bonus                                                                   #
# in addition to the above, you may wish to pretty-print your binary tree #
# in a human readable text-based format similar to the following:         #
#                                                                         #
#            1                                                            #
#           / \                                                           #
#          3   2                                                          #
#         / \ / \                                                         #
#        7  6 5  4                                                        #
#                                                                         #
###########################################################################

use strict;
use warnings;

use tree::binary;
use tree::binary::visitor::breadthfirsttraversal;

# Not pretty for trees a depth > 3.
sub printPretty {
    my $tree = $_[0];
    my $height = $tree -> height;
    my $edge = $height;

    my $visitor = Tree::Binary::Visitor::BreadthFirstTraversal -> new;
    $tree -> accept($visitor);

    my @nodes = ($visitor -> getResults);
    my $i = 0;
    my $leadPos = $height + 2;
    my $leadingSpace = ' ' x $leadPos;
    my $spaceBetween = ' ';

    for (my $level = 0; $level < $height; ++$level) {
        $leadingSpace = ' ' x $leadPos;

        if ($level > 0) {
            print $leadingSpace;
            my $betweenLines = ' ';
            for (my $lineSets = (2**$level) / 2 ; $lineSets > 0; --$lineSets) {
                print '/' . $betweenLines . '\\' . $betweenLines;
            }

            print "\n";
            --$leadPos;
            $leadingSpace = ' ' x $leadPos;
       }

        print $leadingSpace;
        --$leadPos;

        for (my $k = 0; $k < 2**$level; ++$k) {
            if ( $level == 1) {
                $spaceBetween = ' ' x 2;
            } elsif ($level == 2) {
                $spaceBetween = ' ' x 1;
            }
            print $nodes[$i++] . $spaceBetween;
            print ' ' if $k % 2 == 0;
        }

        print "\n";
    }
    print "\n";
}

my($bTree) = Tree::Binary -> new('1')
    -> setLeft(
        Tree::Binary -> new('2')
              -> setLeft (
                  Tree::Binary -> new('4')
              )
              -> setRight(Tree::Binary -> new('5')
              )
    )
    -> setRight (
        Tree::Binary -> new('3')
              -> setLeft (
                  Tree::Binary -> new('6')
              )
              -> setRight (
                      Tree::Binary -> new('7')
              )
    );


printPretty $bTree;

$bTree->mirror();               # The module method does all the work for the inversion.

printPretty $bTree;

__END__
output:

     1  
    / \ 
   2   3  
  / \ / \ 
 4  5 6  7 

     1  
    / \ 
   3   2  
  / \ / \ 
 7  6 5  4 

