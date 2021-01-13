#!perl6
# Task 2 Challenge 056 Solution by kevincolyer
# Path Sum
# You are given a binary tree and a sum, write a script to find 
# if the tree has a path such that adding up all the values along 
# the path equals the given sum. Only complete paths (from root 
# to leaf node) may be considered for a sum.
# ExampleGiven the below binary tree and sum = 22,
#           5
#          / \
#         4   8 
#        /   / \
#       11  13  9
#      /  \      \
#     7    2      1
# For the given binary tree, 
# the partial path sum 5 → 8 → 9 = 22 is not valid.
# The script should return the path 5 → 4 → 11 → 2 whose sum is 
# 22.

class node {
    has Int $.value;
    has node $.left;
    has node $.right;
}

my $root = node.new(value => 5, 
    left => node.new(value => 4, left => node.new(value =>11, left=>node.new(value=>7),right => node.new(value => 2))),
    right => node.new(value=>8,left=>node.new(value=>13),right=> node.new(value=>9,right=> node.new(value=>1)))
    );


sub dfs($node,$target,$new=True) {
    state $found=False;
    state @values;
    if $new { 
        @values = Empty; 
        $found=False; 
    }
    my $siblings=0;
    @values.push: $node.value;

    if $node.left:defined { 
        $siblings++;
        dfs($node.left, $target,False);
        return @values if $found;
    }

    if $node.right:defined { 
        $siblings++;
        dfs($node.right,$target,False);
        return @values if $found;
    } 
    
    # lone leaf
    if $siblings==0 and @values.sum==$target {
        $found=True;
        return @values;
    }
    
    # not found so back track
    @values.pop;
    return Empty;
}
multi MAIN('test') {
    dfs($root,$_).say for 15..30;
}

multi MAIN(Int $target where * > 0) {
    my @values=dfs($root,$target);
    if @values == Empty {
        say "Target sum [$target] not found in tree";
        exit;
    }
    say @values.join(" -> ") ~ " = $target";
}
