#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##







class Node {
    has Any   $.value   is rw;
    has Node  $.left    is rw;
    has Node  $.right   is rw;
    has       $.child_l is rw = 0;
    has       $.child_r is rw = 0;
}

class BTree {
    has Node $.root     is rw;
    has      $.diameter is rw = 0 ;
  
    submethod BUILD (:@serial?) {
        $!root = Node.new;
        self.load_serial(@serial) if @serial.elems > 0;
    }
    
    method load_serial($data) {
        self!add_children($.root, $data, 0);
        
        method !add_children($node, $data, $idx) {
        ## add value from data array at index and recursively walk tree to children
            $node.value = $data[$idx];
            if $data[ 2 * $idx + 1 ].defined {
                $node.left = Node.new;
                self!add_children($node.left, $data, 2 * $idx + 1);
            }
            if $data[ 2 * $idx + 2 ].defined {
                $node.right = Node.new;
                self!add_children($node.right, $data, 2 * $idx + 2);
            }   
        }
    }

    
    method dump_serial() {
    ## write serialized array from root
        my @dump = [];
        self!dump_children($.root, @dump, 0);
        return @dump;
        
        method !dump_children($node, @dump, $idx) {
        ## add value to dump array at index and recursively walk tree to children
            @dump[$idx] = $node.value;
            if $node.left {
                self!dump_children($node.left, @dump, 2 * $idx + 1);
            }
            if $node.right {
                self!dump_children($node.right, @dump, 2 * $idx + 2);
            }   
        }        
    }
    
    method get_diameter() {
    ## fetch diameters using LRN traversal, update $self.diameter when necessary
    ## return diameter
        self!fetch_diameters($.root);
        return $.diameter;
    
        method !fetch_diameters($node) {
            if $node.left {
                $node.child_l = self!fetch_diameters($node.left)
            }
            if $node.right {
                $node.child_r = self!fetch_diameters($node.right)
            }    
            $.diameter = ($.diameter, $node.child_l + $node.child_r).max;
            return ($node.child_l, $node.child_r).max + 1;
        }
    
    
    }
    
}

sub MAIN () {

    my @data =  1, 
                2, 2, 
                3, 3, Nil, Nil,   
                 4, 4, 4, 4, Nil, Nil, Nil, Nil,
                Nil, 5, Nil, Nil, 5, 5, Nil, 5,
                Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil,
                Nil, Nil, 6, Nil, Nil, Nil, Nil, Nil,
                Nil, Nil, Nil, Nil, Nil, Nil, Nil, 6,
                Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil,
                Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil ;
                
    my $tree = BTree.new(serial => @data);
    say "Diameter: ", $tree.get_diameter;
    
    ## pretty print the input data
    print_tree(@data);

}

sub print_tree (@tree) {
## originally created for PWC 057-1 "invert-sugar"
## updated for box drawing elements and cleaned up for PWC 113
    constant vert   = Q<┃> ;
    constant rtee   = Q<┣> ;
    constant ltee   = Q<┫> ;
    constant downr  = Q<┏> ;
    constant downl  = Q<┓> ;
    sub space ($val) {  Q< > x $val }
    sub dash  ($val) {  Q<━> x $val }
    
    sub get_level ($n) {
    ## determines the 0-based level of a node from its index
        $n > 0 
            ?? (($n+1).log/(2).log ).Int
            !! 0;
    }

    ## find the widest string representation in the array and return the width
    my $value_width = @tree.max({$_.chars}).chars;       
    
    ## magic trick here, as we get longer values we pretend we're at the top of
    ## a larger tree to keep from running out of space between adjacent values
    ## between two parent nodes on the lowest level
    my $num_levels  = get_level(@tree.elems - 1 ) + ($value_width/2).Int;  


    my $idx = 0;    
    while $idx < @tree.elems {
        my $level  = get_level($idx);
        
        my $spacer = 2**($num_levels - $level + 1);     
        my $white  = ($spacer/2 + 1 + $value_width) > $spacer 
                            ?? $spacer 
                            !! $spacer/2 + 1 + $value_width;
        my $dashes = $spacer - $white;
        my $level_node_count = 2 ** $level;
        my $node_line;
        my $vert_line;
        
        ## draw the nodes of each level and any connecting lines to the next 
        for 1..$level_node_count {
        
            ## if the node is defined draw it in
            if (defined @tree[$idx]) {

                ## centers value in a slot $value_width wide, leaning right for odd fits 
                my $this_width      = @tree[$idx].chars;
                my $right_pad_count = (($value_width-$this_width)/2).Int;
                my $right_pad       = space($right_pad_count);
                my $left_pad        = space($value_width - $this_width - $right_pad_count);
                my $value_format    = "{$left_pad}%{$this_width}s{$right_pad}";
                my $node            = sprintf $value_format, @tree[$idx];

                ## draw connecting lines if children present, or whitespace if not
                my $left_branch  = (defined @tree[2 * $idx + 1]) 
                                    ?? space($white-2) ~ downr  ~ dash($dashes) ~ ltee
                                    !! (space($spacer-1) ~ vert);
                my $right_branch = (defined @tree[2 * $idx + 2])
                                    ?? rtee ~ dash($dashes) ~ downl ~ space($white-$value_width-2)
                                    !! vert ~ space($spacer-$value_width-1);
                $node_line      ~= $left_branch ~ $node ~ $right_branch;
                
                ## construct the vert connector line
                my $left_vert    = (defined @tree[2 * $idx + 1]) 
                                    ?? space($spacer/2+$value_width-1) ~ vert ~ space($dashes+1)
                                    !! space($spacer);
                my $right_vert   = (defined @tree[2 * $idx + 2])
                                    ?? space($dashes+$value_width+1) ~ vert ~ space($spacer/2-1)
                                    !! space($spacer);
                $vert_line      ~= $left_vert ~ $right_vert;
            }
            ## else insert equivalent whitespace
            else {
                $node_line ~= space($spacer * 2);     
                $vert_line ~= space($spacer + 2 + $dashes*2 + $value_width*2);
            }
            $idx++;
        }
        say $node_line;
        say $vert_line;
    }
}
