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

1;