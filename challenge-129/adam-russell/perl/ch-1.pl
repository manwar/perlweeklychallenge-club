use strict;
use warnings;
##
# You are given a tree and a node of the given tree.
# Write a script to find out the distance of the 
# given node from the root.   
##
package Tree129{
    use boolean;  
    use Tie::RefHash;
    use Class::Struct; 

    package Node{
        use boolean;  
        use Class::Struct; 
        struct(
            value => q/$/,
        );  
        true; 
    }  
    
    package Edge{
        use boolean;  
        use Class::Struct; 
        struct(
            weight => q/$/,
            source => q/Node/,
            target => q/Node/
        );  
        true; 
    }  
   
    struct(
        root => q/Node/,
        edges => q/%/
    );   

    sub print_tree{ 
        my($self) = @_;   
        for my $edge_source (keys %{$self->edges()}){
            for my $target (@{$self->edges()->{$edge_source}}){
                print $edge_source->value() . "->" . $target->value() . "\n";
            }
        }
    }  
    
    sub distance{
        my($self, $target) = @_;
        my $distance = 0;
        return $distance if($self->root()->value() == $target);
        my @nodes = @{$self->edges()->{$self->root()}};
        my @edge_sources = keys %{$self->edges()};
        do{
            $distance++;
            return $distance if((grep {$_->value() == $target} @nodes) > 0);
            my @child_nodes;
            for my $node (@nodes){
                my @k = grep {$_->value() == $node->value()} @edge_sources;
                push @child_nodes, @{$self->edges()->{$k[0]}} if $k[0] && $self->edges()->{$k[0]};
            }
            
            @nodes = @child_nodes;
        }while(@nodes);
        return -1;
    }

    sub insert{
        my($self, $source, $target) = @_;   
        if(!$self->root()){      
            $self->root(new Node(value => $source));  
            tie %{$self->edges()}, "Tie::RefHash";
            $self->edges($self->root() => [new Node(value => $target)]);          
        }   
        else{
            my $found = false;
            for my $edge_source (keys %{$self->edges()}){
                if($edge_source->value() == $source){
                    push @{$self->edges()->{$edge_source}}, new Node(value => $target);
                    $found = true;
                }
            }
            if(!$found){
                $self->edges()->{new Node(value => $source)} = [new Node(value => $target)];
            }
        }
    }  
    true; 
}

package main{
    my $tree = new Tree129(); 
    $tree->insert(1, 2); 
    $tree->insert(1, 3); 
    $tree->insert(3, 4); 
    $tree->insert(4, 5); 
    $tree->insert(4, 6); 
    print $tree->distance(6) . "\n";
    print $tree->distance(5) . "\n";
    print $tree->distance(2) . "\n";
    print $tree->distance(4) . "\n";
} 
