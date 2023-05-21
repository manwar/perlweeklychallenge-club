#!/usr/bin/perl
use strict;
use warnings;

package Node;

sub new {
    my ( $class, $data ) = @_;
    my $self = {
        data => $data,
        next => undef
    };
    return bless $self, $class;
}

package LinkedList;

sub new {
    my ($class) = @_;
    my $self = { head => undef };
    return bless $self, $class;
}

sub append {
    my ( $self, $data ) = @_;
    my $new_node = Node->new($data);
    if ( !$self->{head} ) {
        $self->{head} = $new_node;
    }
    else {
        my $cur = $self->{head};
        $cur = $cur->{next} while $cur->{next};
        $cur->{next} = $new_node;
    }
}

sub remove_from_end {
    my ( $self, $n ) = @_;
    my $size = 0;
    my $cur  = $self->{head};
    while ($cur) {
        $size++;
        $cur = $cur->{next};
    }
    if ( $n >= $size ) {
        $self->{head} = $self->{head}->{next};
    }
    else {
        $cur = $self->{head};
        for ( 1 .. $size - $n - 1 ) {
            $cur = $cur->{next};
        }
        $cur->{next} = $cur->{next}->{next} if $cur->{next};
    }
}

sub print {
    my ($self) = @_;
    my @values;
    my $cur = $self->{head};
    while ($cur) {
        push @values, $cur->{data};
        $cur = $cur->{next};
    }
    print join( " -> ", @values ), "\n";
}

# Tests
my $ll = LinkedList->new();
for my $i ( 1 .. 5 ) {
    $ll->append($i);
}

for my $i ( 1 .. 6 ) {
    $ll->remove_from_end($i);
    $ll->print();
}
