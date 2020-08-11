use strict;
use warnings;
use experimental qw(signatures);

#List node class
package Node;

sub new ($class, $val, $next_node=undef) {
    bless {val => $val, next_node => $next_node}, $class;
}

#LinkedList class
package Listy;

sub new ($class, $list) {
    my $head = my $last = undef;

    for (@$list) {
        my $node = Node->new ($_);
        if (defined $last) {
            $last->{next_node} = $node;
            $last = $node;
        }
        else {
            $head = $last = $node;
        }        
    }
    bless {head => $head, last1 => $last}, $class
}

sub is_empty ($self) {
    not defined $self->{head};
}

sub print_list ($self) {
    if ($self->is_empty) {
        print "empty";
    }
    else {
        for (my $i = $self->{head}; defined $i; $i = $i->{next_node}) {
            print $i->{val};
            print "->" unless $i == $self->{last1};
        }
    }
}

sub parent_of_node ($self, $node, $start_node=undef) {
    $start_node //= $self->{head};
    return $start_node if $start_node == $node;
    
    $start_node = $start_node->{next_node} while $start_node->{next_node} != $node;
    return $start_node;
}

sub shift_right_rotate ($self, $i, $j) {
    my $parent_i = $self->parent_of_node($i);
    my $parent_j = $self->parent_of_node($j, $i);

    $parent_j->{next_node} = $j->{next_node};
    $self->{last1} = $parent_j if $j == $self->{last1};
    $j->{next_node} = $i;
    if ($parent_i == $i) {
        $self->{head} = $j;
    }
    else {
        $parent_i->{next_node} = $j;
    }
}

sub partition ($self, $k) {
    my $i = $self->{head};
    $i = $i->{next_node} if defined $i && $i->{val} < $k;
    return unless defined $i;
    
    while (1) {
        my $j = $i->{next_node};
        $j = $j->{next_node} while defined $j && $j->{val} >= $k;
        return unless defined $j;
        $self->shift_right_rotate($i, $j);
    }
}

my $list = Listy->new ([1, 4, 3, 2, 5, 2]);
$list->partition(3);
$list->print_list;