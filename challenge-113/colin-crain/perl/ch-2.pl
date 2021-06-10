#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       image-is-the-difference.pl
#
#         Recreate Binary Tree
#         Submitted by: Mohammad S Anwar
#         You are given a Binary Tree.
# 
#         Write a script to replace each node of the tree with the sum of all
#         the remaining nodes.
# 
#         Example
#         
#             Input Binary Tree
#                     1
#                    / \
#                   2   3
#                  /   / \
#                 4   5   6
#                  \
#                   7
#  
#             Output Binary Tree
#                     27
#                    /  \
#                   26  25
#                  /   /  \
#                 24  23  22
#                  \
#                  21

#         method:
#             I have nothing against binary trees, or really any kinds of trees,
#             arboreal or conceptual. I like trees. They give me pleasure to
#             watch, shade to cool me, and provide the stuff I like to breathe:
#             day in, day out, all of this for free without a complaint to be
#             heard. I can't say they never hurt anyone, but I do think it
#             highly unlikely they ever did so on purpose. It might be more fair
#             to blame gravity for that falling branch than the poor being that
#             lost its appendage. Or the ground the hiker was standing on, for
#             that matter, for the sudden stop. The ground is very dangerous
#             stuff. Every year, almost every accident that happens happens on
#             the ground. Someone should look into this. 

#             That said, I am not that fond of working with binary trees in
#             these challenges. It's not the trees themselves; writing methods
#             to do clever stuff is great and all. What bugs me is the I/O
#             portion. There's no really good satisfactory way to encode a tree
#             for easy transport. They generally end up a jumble of brackets
#             that you pray hasn't been corrupted. They aren't hard to work
#             with, they're hard for humans to read and write.
# 
#             The data is input as a serialized tree in an array. In this format
#             each position of a theoretical full tree in a breadth-first
#             traversal is assigned a sequential element in an array, whether it
#             contains a node or not. Thus the root layer is a single element at
#             index [0], the next layer two indices at [1] and [2], the next
#             [3],[4],[5] and [6], etc. Empty nodes, as we said, leave holes in
#             the sequence filled with `undef`. Because things are complicated
#             enough the data is directly written in to the script as an
#             existing Perl array. 
# 
#             One primary advantage of this format is that the parent and child
#             nodes maintain a clearly defined relationship, with the children
#             for a given node at index [n] occupying indices [2n+1] and [2n+2].
# 
#             I decided to write up a proper set of classes to hold the data
#             structure this time. The data structure is read in recursively
#             through the parent-child relationship, but after that the nodes
#             like to themselves through "left" and "right" attriubutes.
# 
#             Two routines descend the trees from the root node, one to add the
#             value of each node to a `sum` attribute, the second to travese
#             again and replace the value of each nod to the summed value minus
#             that value, being the sum of all the other values in the tree.
# 
#             To print the tree I brought out the pretty print routine from PWC
#             057 and updated it. This operates on serialized data, so a serial
#             dump routine was fashioned to mirror the load routine. I cleaned
#             it up and worked it over some more, so among other things now it
#             uses Unicode box-drawing characters, giving it a sleek new art
#             deco look. 
#
# 
#                             ┏━━━━━━━━━━━━━━┫6┣━━━━━━━━━━━━━━┓               
#                             ┃                               ┃               
#                     ┏━━━━━━┫8┃                      ┏━━━━━━┫6┣━━━━━━┓       
#                     ┃                               ┃               ┃       
#                 ┏━━┫2┣━━┓                       ┏━━┫3┣━━┓       ┏━━┫9┣━━┓   
#                 ┃       ┃                       ┃       ┃       ┃       ┃   
#               ┏┫9┣┓    ┃3┣┓                   ┏┫5┣┓    ┃1┃     ┃2┣┓   ┏┫1┣┓ 
#               ┃   ┃       ┃                   ┃   ┃               ┃   ┃   ┃ 
#              ┃6┃ ┃9┃     ┃6┃                 ┃3┃ ┃5┃             ┃1┃ ┃1┃ ┃1┃
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


package Node;
use Moo;

    has value => ( is => 'rw' );
    has left  => ( is => 'rw' );
    has right => ( is => 'rw' );


package BTree;
use Moo;
use feature qw(signatures);
no warnings 'experimental::signatures';

    has root => (
        is => 'rw',
        default => sub { Node->new() }
    );

    has sum => (
    ## the sum of all values in the tree
        is => 'rw',
        default => 0
    );
    
    sub load_serial ($self, $data) {
    ## build tree from serialized array from root
        $self->_add_children($self->root, $data, 0);
    }
    
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
    
    sub dump_serial ($self) {
    ## write serialized array from root
        my $dump = [];
        $self->_dump_children($self->root, $dump, 0);
        return $dump;
    }
    
    sub _dump_children ($self, $node, $dump, $idx) {
    ## add value to dump array at index and recursively walk tree to children
        $dump->[$idx] = $node->value;
        if (defined $node->left) {
            $self->_dump_children($node->left, $dump, 2 * $idx + 1);
        }
        if (defined $node->right) {
            $self->_dump_children($node->right, $dump, 2 * $idx + 2);
        }   
    }
   
    sub descend_and_sum ($self, $node = $self->root) {
    ## NLR preorder traversal and add node values to package sum attribute
        $self->sum( $self->sum + $node->value ); 
        if (defined $node->left) {
            $self->descend_and_sum($node->left);
        }
        if (defined $node->right) {
            $self->descend_and_sum($node->right);
        } 
    }       
    
    sub descend_insert_diff ($self, $node = $self->root) {
    ## NLR preorder traversal and replace node values with package sum - value
        $node->value($self->sum - $node->value);
        if (defined $node->left) {
            $self->descend_insert_diff($node->left);
        }
        if (defined $node->right) {
            $self->descend_insert_diff($node->right);
        }
    }
    
    


package main;
use warnings;
use strict;
use feature ":5.32";
use feature qw(signatures);
no warnings 'experimental::signatures';

my @data = (6, 
            8, 6, 
            2, undef, 3, 9, 
            undef, 3, undef, undef, 5, 1, undef, 1);


my $tree = new BTree;
$tree->load_serial(\@data);

$tree->descend_and_sum;
$tree->descend_insert_diff;

my $dump = $tree->dump_serial;


## output
say "Input:\n";
print_tree(@data);
say '';
say "Output:\n";
print_tree($dump->@*);

## predeclare
sub space;
sub dash;
sub vert;
sub rtee;
sub ltee;
sub downr;
sub downl;

sub print_tree (@tree) {
## originally created for PWC 057-1 "invert-sugar"
## updated for box drawing elements and cleaned up for PWC 113
    my $value_width = get_max_value_width(@tree);       
    
    ## magic trick here, as we get longer values we pretend we're at the top of
    ## a larger tree to keep from running out of space between adjacent values
    ## between two parent nodes on the lowest level
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

                ## centers value in a slot $value_width wide, leaning right for odd fits 
                my $this_width      = length($tree[$index]);
                my $right_pad_count = int(($value_width-$this_width)/2);
                my $right_pad       = space($right_pad_count);
                my $left_pad        = space($value_width - $this_width - $right_pad_count);
                my $value_format    = "${left_pad}%${this_width}s${right_pad}";
                my $node            = sprintf $value_format, $tree[$index];

                ## draw connecting lines if children present, or whitespace if not
                my $left_branch  = defined @tree[2 * $index + 1] 
                                    ? space($white-2) . downr  . dash($dashes) . ltee
                                    : space($spacer-1). vert;
                my $right_branch = defined $tree[2 * $index + 2]
                                    ? rtee . dash($dashes) . downl . space($white-$value_width-2)
                                    : vert . space($spacer-$value_width-1);
                $node_line      .= $left_branch . $node . $right_branch;
                
                ## construct the vert connector line
                my $left_vert    = defined $tree[2 * $index + 1] 
                                    ? space($spacer/2+$value_width-1) . vert . space($dashes+1)
                                    : space($spacer);
                my $right_vert   = defined $tree[2 * $index + 2]
                                    ? space($dashes+$value_width+1) . vert . space($spacer/2-1)
                                    : space($spacer);
                $vert_line      .= $left_vert . $right_vert;
            }
            ## else insert equivalent whitespace
            else {
                $node_line .= space(2 * $spacer);     
                $vert_line .= space($spacer + 2 + $dashes*2 + $value_width*2);
            }
            $index++;
        }
        say $node_line;
        say $vert_line;
    }
}

sub space ($val) { return q( ) x $val }
sub dash  ($val) { return q(━) x $val }
sub vert         { return q(┃) }
sub rtee         { return q(┣) }
sub ltee         { return q(┫) }
sub downr        { return q(┏) }
sub downl        { return q(┓) }

sub get_level ($n) {
## determines the 0-based level of a node from its index
    return $n > 0 ? int log($n+1)/log(2) 
                  : 0;
}

sub get_max_value_width (@tree) { 
## finds the widest string representation in the array and returns the width
    my $max = 0;
    $_ > $max and $max = $_ for map { scalar split // } grep defined, @tree;
    return $max;
}


