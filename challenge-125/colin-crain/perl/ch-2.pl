#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       tree-rings.pl
#
#       Binary Tree Diameter
#         Submitted by: Mohammad S Anwar
#         You are given binary tree as below:
# 
#                     1
#                    / \
#                   2   5
#                  / \ / \
#                 3  4 6  7
#                        / \
#                       8  10
#                      /
#                     9
# 
#         Write a script to find the diameter of the given binary tree.
# 
#         The diameter of a binary tree is the length of the longest path
#         between any two nodes in a tree. It doesn’t have to pass through
#         the root.
# 
#         For the above given binary tree, possible diameters (6) are:
# 
#         3, 2, 1, 5, 7, 8, 9
# 
#         or
# 
#         4, 2, 1, 5, 7, 8, 9
# 
#         UPDATE (2021-08-10 17:00:00 BST): Jorg Sommrey corrected the
#         example. The length of a path is the number of its edges, not the
#         number of the vertices it connects. So the diameter should be 6,
#         not 7.
# 
#
#         method:
# 
#             You can tell the age of a tree from the number of rings it
#             has encircling its core.  The tree never stops growing, but
#             throughout the year it thrives in the summer, soaking up the
#             warmth and light of the sun to power its processes, puttin
#             gon weight for a barren winter to come, when it will berely
#             expand at all. The cycles, then, give the continual tree
#             growth its charateristic ring pattern, and serve as a commentary
#             on the world, rather than the tree itself. 

#             For this challenge we will bring out the set of binary tree
#             classes we built for PWC 113, and because crafting input can
#             be so difficult when constructing trees to a certain spec,
#             we'll add the tree print routine first crafted for PWC 057 to
#             help us, refactored and tightened yet again into a nice
#             self-contained package. Which, I suppose, is the next step
#             for the binary tree hardware. For now, though, as these are
#             demonstrations, I think it better to present everything
#             upfront, instead of hidden away in a module performing magic.
# 
#             The beauty of having a framework of course, is that extending
#             it can be quite simple, and we can focus our attention on
#             what we want done, and less so on how we go about doing that.
# 
#             I am again without internet, so, without any external
#             knowledge I was left to my own devices. I normally avoid
#             actully looking up the answers, preferring to let things bacg
#             around in my head for a few days should the problem be
#             present no obvious plan of attack, but in the senseless
#             pursuit of knowledge I usually allow myself the endless
#             rabbit hole that is WikiPedia, and here I don't even have
#             that.
# 
#             But no matter. The first thing that stood out was the comment
#             that the longest path need not go through the root node. Well
#             how would that present itself? In a highly asymmetrical tree,
#             the right side, for instance, might have many levels split
#             from the right child of the root, and the left child may have
#             few if any. In that case it is possible to traverse upwards
#             from the left child of the right side, up to the right root
#             child node, and then back down the right side to make the
#             longest traversal.
# 
#             On the other hand, it becomes apparent that although the top
#             node need not be the root, the longest traversal will always
#             have a fundimental vee-shape, up from a left leaf to an apex
#             node and down again to some right leaf at the furthest
#             extant. Doing a depth-first traversal is something we know
#             how to do. The question, then, is which node is our apex?
# 
#             We could try them all, which would be a bit wasteful, as we
#             traversed again and again over the same leaves computing the
#             longest path each way for each node.
# 
#             On the other hand, we could take a page from dynamic
#             programming and start at the leaves, computing the longest
#             partial path from each node to the bottom and work our way
#             upwards through the tree.
# 
#             The dynamic part is that at each node we set up a place to
#             put two values, say a little array, that holds the maximum
#             traversal down the left child path, and the complement vaalue
#             for the right. Then, when iterating recursively through the
#             tree, at the end of the recursive step we return the larger
#             of the two values, plus 1 for the path connecting to the
#             parent. The parent then inserts this return value into its
#             child-disance-log-thingy in the left or right position as
#             warranted. In this way if we do a depth-first LRN traversal
#             recursively, when the recursions collapse upwards they will
#             build out the child data for each node as the recursions
#             return.
# 
#             The diameter of the tree at each node is the sum of these two
#             values, the left child distance plus the right. By adding a
#             package variable to the tree object, at each step once the
#             child values have been filled in we can compare the diameter
#             at that node to the tree value, and update that if necessary
#             to reflect the maximum diameter.
# 
#             Implementing this involved adding a child_counts attribute to
#             the Node object, and diameter attribute to the Btree object.
#             A method, get_diameter(), does the depth-first LRN traversal
#             as described above.
# 
#             For the framework, and the additional print_tree() routine,
#             I've moved all of the helper routines into their wrappers,
#             encapsulating everything each method needs to do its thing. I
#             think this has a cleaner feel to it.
# 
#             The print_tree() routine is included to facilitate
#             manipulating the input data list. As the values don't matter
#             to this challenge, I've used the number of its level as the
#             value for each node in the demonstration.

            


#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## 





package Node;
use Moo;

    has value        => ( is => 'rw' );
    has left         => ( is => 'rw' );
    has right        => ( is => 'rw' );
    has child_counts => ( is => 'rw',
                          default => sub { [0,0] } );
        
package BTree;
use Moo;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

    has root => (
        is => 'rw',
        default => sub { Node->new() }
    );
    
    has diameter => (
    ## the diameter of the tree
        is => 'rw',
        default => 0
    );

    sub load_serial ($self, $data) {
    ## build tree from serialized array, from the root node
    
        sub _add_children ($self, $node, $data, $idx) {
        ## add value from data array at index and recursively walk tree to children
            $node->value( $data->[$idx] );
            if (defined $data->[ 2 * $idx + 1 ]) {
                $node->left( Node->new );
                $self->_add_children($node->left, $data, 2 * $idx + 1);
            }
            if (defined $data->[ 2 * $idx + 2 ]) {
                $node->right( Node->new );
                $self->_add_children($node->right, $data, 2 * $idx + 2);
            }   
        }
    
        $self->_add_children($self->root, $data, 0);
    }
    
    sub dump_serial ($self) {
    ## write serialized array from root
        my $dump = [];
        
        sub _dump_children ($self, $node, $dump, $idx = 0) {
        ## add value to dump array at index and 
        ## recursively walk tree to children
            $dump->[$idx] = $node->value;
            if (defined $node->left) {
                $self->_dump_children($node->left, $dump, 2 * $idx + 1);
            }
            if (defined $node->right) {
                $self->_dump_children($node->right, $dump, 2 * $idx + 2);
            }   
        }
        
        $self->_dump_children($self->root, $dump);
        return $dump;
    }
    
#     sub get_diameter ( $self, $node = $self->root ) {
#     ## LRN traversal to gather child counts and update diameter
#         if (defined $node->left) {
#             $node->child_counts->[0] = $self->get_diameter($node->left);
#         }
#         if (defined $node->right) {
#             $node->child_counts->[1] = $self->get_diameter($node->right);
#         }
#         my $children = $node->child_counts->[0] + $node->child_counts->[1];
#         if ($children > $self->diameter) {
#             $self->diameter( $children );
#         }
#         return ( $node->child_counts->[0] > $node->child_counts->[1] 
#             ? $node->child_counts->[0]
#             : $node->child_counts->[1]
#         ) + 1
#     }

    sub get_diameter ($self) {
    
        sub _get_diameter ( $self, $node = $self->root ) {
        ## LRN traversal to gather child counts and update diameter
            if (defined $node->left) {
                $node->child_counts->[0] = $self->_get_diameter($node->left);
            }
            if (defined $node->right) {
                $node->child_counts->[1] = $self->_get_diameter($node->right);
            }
            my $children = $node->child_counts->[0] + $node->child_counts->[1];
            if ($children > $self->diameter) {
                $self->diameter( $children );
            }
            return ( $node->child_counts->[0] > $node->child_counts->[1] 
                ? $node->child_counts->[0]
                : $node->child_counts->[1]
            ) + 1
        }

        $self->_get_diameter;
        return $self->diameter;
    }
    
    sub print_tree ($self) {
    ## originally created for PWC 057-1 "invert-sugar"
    ## updated for box drawing elements and cleaned up for PWC 113
    ## and again for PWC 125
            
        my @tree = $self->dump_serial->@*;
        
        ## predeclare some character representations
        sub space ($val) { return q( ) x $val }
        sub dash  ($val) { return q(━) x $val }
        sub vert         { return q(┃) }
        sub rtee         { return q(┣) }
        sub ltee         { return q(┫) }
        sub downr        { return q(┏) }
        sub downl        { return q(┓) }

        ## determines the 0-based level of a node from its index
        sub get_level ($n) {
            return $n > 0 ? int log($n+1)/log(2) 
                          : 0;
        }       
        
        ## finds the widest string representation in the array and returns
        ## the width
        my $value_width = 0;
        $_ > $value_width and $value_width = $_ for map { scalar split // } 
                                                    grep defined, @tree;
    
        ## magic trick here, as we get longer values we pretend we're at
        ## the top of a larger tree to keep from running out of space
        ## between adjacent values between two parent nodes on the lowest
        ## level
        my $num_levels  = get_level(scalar @tree - 1 ) + int($value_width/2);  
        my $index = 0;
    
        while ($index < scalar @tree) {
            my $level  = get_level($index);
        
            my $spacer = 2**($num_levels - $level + 1);     
            my $white  = ($spacer/2 + 1 + $value_width) > $spacer 
                                ? $spacer 
                                : $spacer/2 + 1 + $value_width;
            my $dashes = $spacer - $white;
            my $level_node_count = 2 ** $level;
            my $node_line;
            my $vert_line;
        
            ## draw the nodes of each level and any connecting lines to the next 
            for (1..$level_node_count) {
        
                ## if the node is defined draw it in
                if (defined $tree[$index]) {

                    ## centers value in a slot $value_width wide, leaning
                    ## right for odd fits 
                    my $this_width      = length($tree[$index]);
                    my $right_pad_count = int(($value_width-$this_width)/2);
                    my $right_pad       = space($right_pad_count);
                    my $left_pad        = space($value_width - $this_width - 
                                            $right_pad_count);
                    my $value_format    = 
                        "${left_pad}%${this_width}s${right_pad}";
                    my $node            = sprintf $value_format, $tree[$index];

                    ## draw connecting lines if children present, or
                    ## whitespace if not
                    my $left_branch  = defined @tree[2 * $index + 1] 
                                        ? space($white-2) . downr  .     
                                            dash($dashes) . ltee
                                        : space($spacer-1). vert;
                    my $right_branch = defined $tree[2 * $index + 2]
                                        ? rtee . dash($dashes) . downl . 
                                            space($white-$value_width-2)
                                        : vert . space($spacer-$value_width-1);
                    $node_line      .= $left_branch . $node . $right_branch;
                
                    ## construct the vert connector line
                    my $left_vert    = defined $tree[2 * $index + 1] 
                                        ? space($spacer/2+$value_width-1) .  
                                            vert . space($dashes+1)
                                        : space($spacer);
                    my $right_vert   = defined $tree[2 * $index + 2]
                                        ? space($dashes+$value_width+1) . vert . 
                                            space($spacer/2-1)
                                        : space($spacer);
                    $vert_line      .= $left_vert . $right_vert;
                }
                ## else insert equivalent whitespace
                else {
                    $node_line .= space(2 * $spacer);     
                    $vert_line .= space( $spacer + 2 + $dashes*2 + 
                                      $value_width*2 );
                }
                $index++;
            }
            say $node_line;
            say $vert_line;
        }
    }

    
package main;
use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

                        
my @data = (1, 
            2, 2, 
            3, 3, undef, undef,   
             4, 4, 4, 4, undef, undef, undef, undef,
            undef, 5, undef, undef, 5, 5, undef, 5,
            undef, undef, undef, undef, undef, undef, undef, undef,
            undef, undef, 6, undef, undef, undef, undef, undef,
            undef, undef, undef, undef, undef, undef, undef, 6,
            undef, undef, undef, undef, undef, undef, undef, undef,
            undef, undef, undef, undef, undef, undef, undef, undef,
            );


my $tree = new BTree;
$tree->load_serial(\@data);

say "Diameter: ", $tree->get_diameter;

say '';
$tree->print_tree;

