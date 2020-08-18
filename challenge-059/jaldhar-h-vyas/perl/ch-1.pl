#!/usr/bin/perl
use 5.020;


package LinkedList {
    use Moo;
    use namespace::autoclean;

    package LinkedList::Node {
        use Moo;
        use namespace::autoclean;

        has _value => (
            is => 'rw',
        );

        has _next => (
            is => 'rw',
            isa => sub { return ref eq 'LinkedList::Node'; },
        );

        sub BUILDARGS {
            my ($orig, $class, @args) = @_;

            return { _value => $args[0], _next => undef };
        }
    }

    has _head => (
        is => 'ro',
        isa => sub { return ref eq 'LinkedList::Node'; },
    );

    sub BUILDARGS {
        my ($orig, $class, @args) = @_;

        return { _head => undef };
    }

    sub add {
        my ($self, $newval) = @_;

        my $v = $self->{_head};

        if ($v) {
            while ($v->{_next}) {
                $v = $v->{_next};
            }
            $v->{_next} = LinkedList::Node->new(value => $newval);
        } else {
            $self->{_head} = LinkedList::Node->new(value => $newval);
        }

        $self->{_count}++;
    }

    sub print {
        my ($self) = @_;

        my $v = $self->{_head};

        while ($v) {
            print $v->{_value} // q{}, q{ };
            $v = $v->{_next};
        }

        print "\n";
    }

    sub attach {
        my ($self, $node) = @_;

        my $v = $self->{_head};

        if ($v) {
            while ($v->{_next}) {
                $v = $v->{_next};
            }
            $v->{_next} = $node;
        } else {
            $self->{_head} = $node;
        }
    }

    sub merge {
        my ($self, $list) = @_;

        my $v = $self->{_head};

        if ($v) {
            while ($v->{_next}) {
                $v = $v->{_next};
            }
            $v->{_next} = $list->{_head};
        } else {
            $self->{_head} = $list->{_head};
        }
    }

    sub partition {
        my ($self, $k) = @_;

        my $higher = LinkedList->new();
        my $lower = LinkedList->new();
        my $same = LinkedList->new();

        my $v = $self->{_head};

        while ($v) {
            my $node = $v;
            $v = $v->{_next};
            $node->{_next} = undef;

            if ($node->{_value} < $k) {
                $lower->attach($node);
            } elsif ($node->{_value} > $k) {
                $higher->attach($node);
            } else {
                $same->attach($node);
            }
        }

        if ($self->{_head}) {
            $self->{_head} = undef;
        }

        $self->merge($lower);
        $self->merge($same);
        $self->merge($higher);
    }

}

package main;
use 5.020;
use warnings;

my $linked_list = LinkedList->new();
$linked_list->add(1);
$linked_list->add(4);
$linked_list->add(3);
$linked_list->add(2);
$linked_list->add(5);
$linked_list->add(2);

$linked_list->partition(3);
$linked_list->print();