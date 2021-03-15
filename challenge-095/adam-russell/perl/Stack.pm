use strict;
use warnings;
package Stack{
    use boolean;
    use Class::Struct;

    struct(
        data => q/@/
    );

    sub push{
        my($self, $n) = @_;
        push @{$self->data()}, $n;
    }

    sub pop{
        my($self, $n) = @_;
        pop @{$self->data()};
    }

    sub top{
        my($self, $n) = @_;
        @{$self->data()}[@{$self->data()} - 1];
    }
    
    sub min{
        my($self, $n) = @_;
        my @sorted = sort {$a <=> $b} @{$self->data()};
        return $sorted[0];
    }
    true;
}   
