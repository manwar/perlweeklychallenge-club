#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package My::Node;
    sub new { bless { value => $_[1] }, $_[0] }
    sub set_next { $_[0]->{next} = $_[1] }

    sub serialize {
        my ($self) = @_;
        my $n = $self;
        my @s;
        while (defined $n) {
            push @s, $n->{value};
            $n = $n->{next}
        }
        @s
    }

    sub new_from_list {
        my ($class, @values) = @_;
        my $self = bless { value => shift @values }, $class;
        my $last = $self;
        for (@values) {
            my $next = $class->new($_);
            $last->set_next($next);
            $last = $next;
        }
        return $self
    }

    sub reorder {
        my ($self) = @_;
        my $current = $self;
        while ($current) {
            my $last = $current;
            my $last_but_one;
            while ($last->{next}) {
                $last_but_one = $last;
                $last = $last->{next};
            }

            undef $last_but_one->{next};
            my $next = $current->{next};
            $current->set_next($last);
            $last->set_next($next);
            $current = $next;
        }
    }
}

use Test::More tests => 2;

my $list = 'My::Node'->new_from_list(1 .. 4);
$list->reorder;
is_deeply [$list->serialize], [1, 4, 2, 3];

my $list2 = 'My::Node'->new_from_list(1 .. 5);
$list2->reorder;
is_deeply [$list2->serialize], [1, 5, 2, 4, 3];
