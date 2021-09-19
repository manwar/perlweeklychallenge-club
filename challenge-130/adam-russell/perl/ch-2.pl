use strict;
use warnings;
##
# You are given a tree.
# Write a script to find out if the given tree is Binary Search Tree (BST).
##
package Tree130{
    use boolean;      
    use Class::Struct; 

    use constant LEFT => 0;
    use constant RIGHT => 1;
    
    package Node{
        use boolean;  
        use Class::Struct; 
        struct(
            value => q/$/,
            left => q/Node/,
            right => q/Node/
        );  
        true; 
    }  
   
    struct(
        root => q/Node/,
        nodes => q/@/
    );   

    sub print_tree{ 
        my($self) = @_;   
        my $left_child = $self->root()->left();
        my $right_child = $self->root()->right();
        print $self->root()->value() . " -> " . $left_child->value() . "\n" if $left_child;
        print $self->root()->value() . " -> " . $right_child->value() . "\n" if $right_child;
        print_tree_r($left_child);
        print_tree_r($right_child);
    }  
    
    sub print_tree_r{ 
        my($node) = @_;   
        my $left_child = $node->left();
        my $right_child = $node->right();
        print $node->value() . " -> " . $left_child->value() . "\n" if $left_child;
        print $node->value() . " -> " . $right_child->value() . "\n" if $right_child;
        print_tree_r($left_child) if $left_child;
        print_tree_r($right_child) if $right_child;
    } 
    
    sub min_tree_value{
        my($node) = @_; 
        my $left_child = $node->left();
        my $right_child = $node->right();
        return $node->value() if !$left_child && !$right_child;
        return [sort {$a <=> $b} ($node->value(), min_tree_value($left_child), min_tree_value($right_child))]->[0];
    }
    
    sub max_tree_value{
        my($node) = @_;   
        my $left_child = $node->left();
        my $right_child = $node->right();
        return $node->value() if !$left_child && !$right_child;
        return [sort {$a <=> $b} ($node->value(), max_tree_value($left_child), max_tree_value($right_child))]->[2];
    }
    
    sub is_bst{
        my($self, $node) = @_;
        return true if !$node;
        my $left_child = $node->left();
        my $right_child = $node->right();
        return false if $left_child && $node->value < max_tree_value($left_child);    
        return false if $right_child && $node->value > min_tree_value($right_child);   
        return false if !$self->is_bst($left_child) || !$self->is_bst($right_child);
        return true;    
    }

    sub insert{
        my($self, $source, $target, $left_right) = @_;   
        if(!$self->root()){      
            $self->root(new Node(value => $source));   
            push @{$self->nodes()},  $self->root();      
        }   
        my $source_node = [grep {$_->value() == $source} @{$self->nodes()}]->[0];
        my $target_node = new Node(value => $target);
        if($source_node){
            $source_node->left($target_node) if $left_right == LEFT;
            $source_node->right($target_node) if $left_right == RIGHT;
            push @{$self->nodes()}, $target_node;
        }
    }  
    true; 
}

package main{
    use constant LEFT => 0;
    use constant RIGHT => 1;
    
    my $tree = new Tree130(); 
    $tree->insert(8, 5, LEFT); 
    $tree->insert(8, 9, RIGHT); 
    $tree->insert(5, 4, LEFT); 
    $tree->insert(5, 6, RIGHT); 
    print $tree->is_bst($tree->root()) . "\n";
    $tree = new Tree130(); 
    $tree->insert(5, 4, LEFT); 
    $tree->insert(5, 7, RIGHT); 
    $tree->insert(4, 3, LEFT); 
    $tree->insert(4, 6, RIGHT); 
    print $tree->is_bst($tree->root()) . "\n";
} 