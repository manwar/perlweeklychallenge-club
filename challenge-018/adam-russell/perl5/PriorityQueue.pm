use strict;
use warnings;
package PriorityQueue{
    use boolean; 
    use Class::Struct;
    package Node{
        use Class::Struct; 
        struct(
            priority => q/$/,
            data => q/$/
        ); 
    }   
    package Heap{
        use Class::Struct;
        struct(
            nodes => q/@/,
            length => q/$/
        );  
    } 
    struct(
        heap => q/Heap/,  
        length => q/$/
    ); 
    sub initialize{
        my($self) = @_;
        my $heap = new Heap(
            nodes => [],
            length => 0
        ); 
        $self->heap($heap); 
    } 
    sub is_empty{
        my($self) = @_;
        return @{$self->heap()->nodes()}; 
    } 
    sub insert_with_priority{
        my($self, $priority, $data) = @_;
        my $i = $self->heap()->length() + 1;
        my $j = int($i / 2);
        while($i > 1 && $self->heap()->nodes()->[$j]->priority() > $priority){
            $self->heap()->nodes->[$i] = $self->heap()->nodes()->[$j]; 
            $i = $j;
            $j = int($j / 2); 
        }   
        $self->heap()->nodes()->[$i] = new Node();
        $self->heap()->nodes()->[$i]->priority($priority);
        $self->heap()->nodes()->[$i]->data($data);
        $self->heap()->length($self->heap()->length + 1); 
    }        
    sub pull_highest_priority_element{
        my($self) = @_;
        if(!$self->is_empty()){
            return undef; 
        }
        my $data = $self->heap()->nodes()->[1]->data(); 
        $self->heap()->nodes()->[1] = $self->heap()->nodes()->[@{$self->heap()->nodes()} + 1]; 
        $self->heap()->length($self->heap()->length() - 1); 
        my $i = 1;
        while($i != $self->heap()->length() + 1){
            my $k = $self->heap()->length + 1 ;
            my $j = $i * 2;
            if($j <= $self->heap()->length() && ($self->heap()->nodes()->[$j]->priority() < $self->heap()->nodes->[$k]->priority())){
                $k = $j; 
            }  
            if($j + 1 <= $self->heap()->length() && ($self->heap()->nodes()->[$j + 1]->priority() < $self->heap()->nodes->[$k]->priority())){
                $k = $j + 1; 
            }  
            $self->heap()->nodes()->[$i] = $self->heap()->nodes()->[$k]; 
            $i = $k;  
        }
        return $data;  
    } 
    true; 
}
