use strict;
use warnings;
##
# You are given two linked list having single digit positive numbers.
# Write a script to add the two linked list and create a new linked 
# representing the sum of the two linked list numbers. The two linked 
# lists may or may not have the same number of elements.
##
package LinkedList129{
    use boolean;
    use Class::Struct;
    
    package Node{
        use boolean;
        use Class::Struct;
        struct(
            value => q/$/,
            previous => q/Node/,
            next => q/Node/
        );
        true;
    }

    struct(
        head => q/Node/,
        tail => q/Node/,
        length => q/$/
    );

    sub stringify{
        my($self) = @_;
        my $s = $self->head()->value();
        my $next = $self->head()->next();
        while($next && $next->next()){
            $s .= " -> " if $s; 
            $s = $s . $next->value();
            $next = $next->next();
        }
        $s = $s . " -> " . $next->value() if $next->value();
        $s .= "\n"; 
        return $s;
    }
    
    sub stringify_reverse{
        my($self) = @_;
        my $s = $self->tail()->value();
        my $previous = $self->tail()->previous();
        while($previous && $previous->previous()){
            $s .= " -> " if $s; 
            $s = $s . $previous->value();
            $previous = $previous->previous();
        }
        $s = $s . " -> " . $self->head()->value();
        $s .= "\n"; 
        return $s;
    }
    
    sub insert{
        my($self, $value) = @_;
        if(!$self->head()){
            $self->head(new Node(value => $value, previous => undef, next => undef));
            $self->tail($self->head());
            $self->length(1);
        }
        else{
            my $current = $self->head();
            my $inserted = false;
            do{
                if(!$current->next()){
                    $current->next(new Node(value => $value, previous => $current, next => undef));
                    $inserted = true; 
                }
                $current = $current->next();
            }while(!$inserted);
            $self->tail($current);
            $self->length($self->length() + 1);
        }
        return $value;
    }
    
    sub add{
        my($self, $list) = @_;
        my $shortest = [sort {$a <=> $b} ($self->length(), $list->length())]->[0];
        my($x, $y) = ($self->tail(), $list->tail());
        my $sum = new LinkedList129();
        my $carry = 0;
        do{
            my $z;
            if($x && $x->value() && $y && $y->value()){
                $z = $x->value() + $y->value() + $carry;
                ($x, $y) = ($x->previous(), $y->previous());
            }
            elsif($x && $x->value() && !$y){
                $z = $x->value() + $carry;
                ($x, $y) = ($x->previous(), undef);
            }
            elsif(!$x->value() && $y->value()){
                $z = $y->value() + $carry;
                ($x, $y) = (undef, $y->previous());
            }
            if(length($z) == 2){
                $carry = 1;
                $sum->insert(int(substr($z, 1, 1)));
            }
            else{
                $carry = 0;
                $sum->insert($z);
            }
            
        }while($x || $y);
        return $sum;
    }
    true;
}

package main{
    my $l0 = new LinkedList129();
    $l0->insert(1);
    $l0->insert(2);
    $l0->insert(3);
    $l0->insert(4);
    $l0->insert(5);
    my $l1 = new LinkedList129();
    $l1->insert(6);
    $l1->insert(5);
    $l1->insert(5);
    my $sum = $l0->add($l1);
    print "    " . $l0->stringify();
    print "+\n";
    print "              " . $l1->stringify();
    print "---" x ($l0->length() * 2) . "\n";  
    print "    " . $sum->stringify_reverse();
}