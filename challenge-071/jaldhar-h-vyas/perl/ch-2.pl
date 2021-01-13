#!/usr/bin/perl

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

    has _count => (
        is => 'ro',
    );

    sub BUILDARGS {
        my ($orig, $class, @args) = @_;

        return { _head => undef, _count => 0 };
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

    sub trim {
        my ($self, $n) = @_;

        my $i = $n > $self->{_count} ? 0 : $self->{_count} - $n;

        if ($self->{_head} && $i == 0) {
            my $temp = $self->{_head};
            $self->{_head} = $self->{_head}->{_next};
            $temp = undef;
        } else {
            my $v = $self->{_head};
            my $c = 0;

            while ($v) {
                $c++;
                if ($c == $i) {
                    if ($v->{_next}) {
                        $v->{_next} = $v->{_next}->{_next};
                    } else {
                        $v = undef;
                    }
                    last;
                }
                $v = $v->{_next};
            }
        }
    }
}

package main;
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N>

    <N>    > 0
-USAGE-
    exit 0;
}

my $N = shift // usage();
if ($N < 1) {
    usage();
}

my $linked_list = LinkedList->new();
$linked_list->add(1);
$linked_list->add(2);
$linked_list->add(3);
$linked_list->add(4);
$linked_list->add(5);

$linked_list->trim($N);
$linked_list->print();