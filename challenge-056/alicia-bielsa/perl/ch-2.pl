use strict;
use warnings;
use Data::Dumper;

#Path Sum

#You are given a binary tree and a sum, write a script to find if the tree
# has a path such that adding up all the values along the path equals the given sum. 
#Only complete paths (from root to leaf node) may be considered for a sum.
#Example

#Given the below binary tree and sum = 22,
#
#          5
#         / \
#        4   8
#       /   / \
#      11  13  9
#     /  \      \
#    7    2      1

#For the given binary tree, the partial path sum 5 → 8 → 9 = 22 is not valid.

#The script should return the path 5 → 4 → 11 → 2 whose sum is 22.

my $sum = 22;
my $binaryTree = buildBinaryTree();
my @aNodes = ();
findCompletePaths(\@aNodes, $binaryTree->{root});

sub findCompletePaths {
    my $refANodes = shift;
    my $node = shift;
    my @aPath =(@{$refANodes},$node->{value} );
    if (defined($node->{left})){
        findCompletePaths(\@aPath,$node->{left});
    }   
    if (defined($node->{right})){            
        findCompletePaths(\@aPath,$node->{right});
    }
    if (scalar @aPath == $binaryTree->{depth}){
        my $total =0;
        map { $total = $total + $_} @aPath;
        if ($total == $sum ){
            foreach my $i (0..$binaryTree->{depth}-1){
                print $aPath[$i].' → ';
            }
            print " sums $sum\n";
        }
    }
}

sub buildBinaryTree {
    my $root = createNode(5);
    $root->{left}  = createNode(4);
    $root->{left}->{left} = createNode(11);
    $root->{left}->{left}->{left} = createNode(7);
    $root->{left}->{left}->{right} = createNode(2);
    $root->{right}  = createNode(8);
    $root->{right}->{left}  = createNode(13);
    $root->{right}->{right}  = createNode(9);
    $root->{right}->{right}->{right}  = createNode(1);
    return  {root => $root, depth => 4};
}

sub createNode {
    my $value = shift;
    my %hTmp =();
    $hTmp{value} = $value;
    $hTmp{left} = undef;
    $hTmp{right} = undef;
    return \%hTmp;
}
