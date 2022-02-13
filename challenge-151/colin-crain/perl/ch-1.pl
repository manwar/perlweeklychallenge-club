#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       no-diving-in-the-shallow-end.pl
#
#       Binary Tree Depth
#         Submitted by: Mohammad S Anwar
#         You are given binary tree.
# 
#         Write a script to find the minimum depth.
# 
#         The minimum depth is the number of nodes from the root to the
#         nearest leaf node (node without any children).
# 
#         Example 1:
# 
#         Input: '1 | 2 3 | 4 5'
# 
#                         1
#                        / \
#                       2   3
#                      / \
#                     4   5
# 
#         Output: 2
# 
#         Example 2:
# 
#         Input: '1 | 2 3 | 4 *  * 5 | * 6'
# 
#                         1
#                        / \
#                       2   3
#                      /     \
#                     4       5
#                      \
#                       6
#         Output: 3
# 
#           method:
# 
#             So... the robust way or the easy way? Whichis to say do we
#             build a tree model, perform a depth-first traversal and note
#             the depth of each node, keeping a running minimal on all leaf
#             nodes? Or do we work the serial flat data-structure instead?
#             In the serial format we have a breath-first order laid out
#             left-to-right
# 
# 
#             One thing different about this tree challenge is that here
#             wee are given example input in a breadth-first sreialized
#             string format. In it, we have levels separated by vertical
#             pipes, with nodes separated by spaces. Empty nodes are
#             indicated by asterisks; in this way the segment from the
#             second example "| 4 *  * 5 |" reveals the thrid level has
#             four nodes and the middle two are null.
# 
#             At the end of the string remaining null nodes to fill out the
#             level are left inplicit and not signified. Although no
#             examples exist, the child nodes of a null node would also be
#             null and so indicated with asterisks, which are necessary to
#             unambiguously mark individual node placement within the
#             structure.
# 
#             All this amounts to a parsable flat format where the child
#             nodes have a mathematical relationship to the indices of the
#             parent: 2n+1 and 2n+2.
# 
#             If we traverse the tree from left to right we can check each
#             node, and, if both children are null we have found a leaf. As
#             the levels ascend from left-to-right the first leaf found
#             will have the minimum depth.
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my $input = shift ;
say mindepth( parse( $input ) ) if defined $input;;

sub parse ( $input ) {
    return map { $_ eq '*' ? undef : $_ } 
           grep { $_ ne '|' } 
           split ' ', $input;
}

sub mindepth ( @tree ) {
    my $level = 1 ;
    my $count = 0 ;
    
    for my $idx ( 0 .. $#tree ) {
        return $level if ( defined $tree[$idx]  
                            and not defined $tree[$idx * 2 + 1]
                            and not defined $tree[$idx * 2 + 2] ) ;
        $level++ and $count = 0 if ++$count == 2 ** ($level-1) ;    
    }
}



use Test::More;

is mindepth( parse('1 | 2 3 | 4 5') ), 2, 'ex-1';
is mindepth( parse('1 | 2 3 | 4 *  * 5 | * 6') ), 3, 'ex-2';
is mindepth( parse('A | B C | D E  F G | H I  J L   M N  O P') ), 4, 'deeper';
is mindepth( parse('X') ), 1, 'root';


done_testing();
