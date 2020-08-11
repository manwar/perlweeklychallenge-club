#!perl
use strict;
use warnings FATAL => qw(all);



=prompt
You are given a binary tree and a sum, write a script to find if the tree has a path such that adding up all the values along the path equals the given sum. Only complete paths (from root to leaf node) may be considered for a sum.

Example:

Given the below binary tree and sum = 22,

          5
         / \
        4   8
       /   / \
      11  13  4
     /  \      \
    7    2      1

For the given binary tree, the partial path sum 5 → 4 → 11 = 20 is not valid.
The script should return the path 5 → 4 → 11 → 2 which sum is 22.

=cut

use Tree::DAG_Node;
use List::Util qw(sum);

my $SUM = shift || 22;

my $root = Tree::DAG_Node -> new({name => 5});
my $l_node = $root->new_daughter({name => 4});
my $r_node = $root->new_daughter({name => 8});

my $n11 = $l_node->new_daughter({name => 11});
my $n7 = $n11->new_daughter({name => 7});
my $n2 = $n11->new_daughter({name => 2});

my $n13 = $r_node->new_daughter({name => 13});
my $n4 = $r_node->new_daughter({name => 4});
my $n1 = $n4->new_daughter({name => 1});


print map("$_\n", @{$root->draw_ascii_tree});

my @paths = $root->leaves_under();
my @output;

for my $path ( @paths )
{
     $path->walk_down({
        callback => sub {
                my $node = shift;
                my @this_sum;
                unshift @this_sum, $node->name; 
                my @anc = $node->ancestors();

                for my $an ( @anc ) 
                { 
                    unshift @this_sum, $an->name; 
                }
                push @output, [@this_sum];
        },
    })
}

# use Data::Dump; dd @output;
@output = grep $SUM == sum(@$_), @output;
print join("->", @$_), $/ for @output;