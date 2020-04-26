#!perl6
# Task 1 Challenge 057 Solution by kevincolyer

# You are given a full binary tree of any height, similar to the one below:
# 
# Write a script to invert the tree, by mirroring the children of every node, from left to right. The expected output from the tree above would be:
# 
# The input can be any sensible machine-readable binary tree format of your choosing, and the output should be the same format.
# 
# BONUS
# In addition to the above, you may wish to pretty-print your binary tree in a human readable text-based format similar to the following:
# 
#        1
#       /  \
#      3    2
#     / \  / \
#    7   6 5  4
# 

# reusing code from previous challenge

class node {
    has Int $.value;
    has node $.left;
    has node $.right;
    has method has-left  { return $!left.defined  };
    has method has-right { return $!right.defined };
    has method is-leaf { return not ( $!left.defined or $!right.defined ) };
}

my $root = node.new(value => 1, 
    left => node.new(value => 2, left => node.new(value =>4),right => node.new(value => 5,left => node.new(value => 10, left => node.new(value=>11) ))),
    right => node.new(value=>3,left=>node.new(value=>6),right=> node.new(value=>7,left=>node.new(value => 8),right=>node.new(value => 9,right=>node.new(value=>12)) ) )
    );

multi MAIN('invert') {
    say "TREE";
    say pretty-print-tree($root);
    my $invert = invert-tree($root);
    say "\nTREE INVERTED";
    say pretty-print-tree($invert);
}

# walk tree and invert (switch l and r) when returning from leaf
# note that nodes are immutadble so require a new node to be created.
sub invert-tree($node) {
    return if not $node.defined;
    return node.new(value => $node.value, left=>invert-tree($node.right),right => invert-tree($node.left));
}


# Helper function for pretty printing - much easier to use array storage of the tree
# for pretty printing as the natural order of the array is similar to the printing order
# each child is 2*parent pos +1 for left and +2 for right
sub tree-to-array($tree,@array,$parent=0,$depth=0) {
    state $maxdepth;
    # reset maxdepth on call to root node
    $maxdepth=0 if $parent==0;
    
    @array[$parent]=$tree.value;
    
    my $d=$depth;
    if $tree.has-left { 
       $d= tree-to-array($tree.left,@array,$parent*2+1,$depth+1)
    }
    if $tree.has-right { 
        $d=tree-to-array($tree.right,@array,$parent*2+2,$depth+1)
    }
 
    $maxdepth=max($d,$maxdepth);
    return $maxdepth;
}

# Quite nasty code to pretty print the tree
sub pretty-print-tree($tree) {
    my @lines;
    my $line="";
    my @pp=Empty;
    # convert linked tree to array tree
    my $d=tree-to-array($tree,@pp);
    
    # iterate over tree starting at parent = 0 position in array
    my $i=0;
    for 0..$d -> $row {
        my $spacingval = (1+$d-$row)**2-2;
        $spacingval-- if $spacingval % 2 == 1; 
        my $spacing =    " " x $spacingval;
        my $bar =        "-" x ($spacing.chars/2);
        my $spaces =     " " x $bar.chars;
        my $rhb =        "-+";
        my $lhb =        "+-";
        my $digits =     "  ";
        my $digit-fmt =  "%2d";

        # print bars then print numbers. 
        # centring happens at the end
        
        my $j=$i;
        my $k=2**$row;
        for ^$k -> $a {
            # skip bars for first line
            if $i>0 {
                # handle even or odd bars and spacing differntly
                if $i %% 2 {
                    $line~= @pp[$i]:exists ?? $bar~$rhb !! $spaces~$digits;
                } else {
                    $line~= @pp[$i]:exists ?? $lhb~$bar !! $digits~$spaces;
                }
                # spacing after lhs and rhs pair (but not at end of line)
                if $i %% 2 and $a != $k-1 { $line~= $spacing };
            }
            $i++;
        }
        @lines.push: $line;
        $line="";
        
        for $j..^$i -> $k {
            # first line is different
            if $k==0 {
                    $line~= sprintf($digit-fmt,@pp[$k]);
                    next;
            }
            # print numbers or blanks depending if the array has a value, left or right side
            if @pp[$k]:exists {
                $line~= $k %% 2 ?? sprintf("$spaces$digit-fmt",@pp[$k]) !! sprintf("$digit-fmt$spaces",@pp[$k]);
            } else {
                $line~= $k %% 2 ?? $spaces~$digits !! $digits~$spaces;
            }
            # spacing after lhs and rhs pair (but not at end of line)
            if $k %% 2 and $k != $i-1 { $line~= $spacing };
        }
        @lines.push: $line;
        $line="";
    }
    
    # centring
    my $longest=@lines[*-1].chars;
    for ^@lines.elems -> $i {
        @lines[$i]=@lines[$i].indent(($longest-@lines[$i].chars)/2);
    }
    return @lines.join("\n");
}
