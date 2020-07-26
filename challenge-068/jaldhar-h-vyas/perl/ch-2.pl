#!/usr/bin/perl

package Node;
use Moo;
use namespace::autoclean;

has _value => (
    is => 'rw',
);

has _next => (
    is => 'rw',
    isa => sub { return ref eq 'Node'; },
);

sub BUILDARGS {
    my ($orig, $class, @args) = @_;

    return { _value => $args[0], _next => undef };
}

sub add {
    my ($self, $newval) = @_;

    my $v = $self;
    while ($v->{_next}) {
        $v = $v->{_next};
    }
    $v->{_next} = Node->new(value => $newval);
}

sub print {
    my ($self) = @_;

    my $v = $self;

    while ($v) {
        print $v->{_value} // q{}, q{ };
        $v = $v->{_next};
    }

    print "\n";
}

sub reorder() {
    my ($self) = @_;

    my $current = $self;

    while ($current) {
        my $last = $current;
        my $second = $current;
        while ($last->{_next}) {
            $second = $last;
            $last = $last->{_next};
        }

        $second->{_next} = undef;
        $last->{_next} = $current->{_next};
        $current->{_next} = $last;

        if ($current->{_next}) {
            $current = $current->{_next}->{_next};
        } else {
            $current = $current->{_next};
        }
    }
}

1;

package main;
use 5.020;
use warnings;

my $linked_list = Node->new(value => 1);
$linked_list->add(2);
$linked_list->add(3);
$linked_list->add(4);

$linked_list->reorder();
$linked_list->print();