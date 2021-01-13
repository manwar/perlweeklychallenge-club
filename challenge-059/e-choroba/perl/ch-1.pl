#!/usr/bin/perl
use warnings;
use strict;

{   package My::Node;

    sub new {
        my ($class, $value) = @_;
        bless [ $value, undef ], $class
    }

    sub Next { $_[0][1] }

    sub value { $_[0][0] }

    sub disconnect {
        my ($self) = @_;
        my $next = $self->Next;
        undef $self->[1];
        return $next
    }

    sub attach {
        my ($self, $new_next) = @_;
        die "Already attached" if defined $self->Next;

        $self->[1] = $new_next;
    }

    sub Last {
        my ($self) = @_;
        my $node = $self;
        $node = $node->Next while $node->Next;
        return $node
    }

    sub append {
        my ($self, $new) = @_;
        if (defined $new) {
            $new->Last->attach($self);
        } else {
            $_[1] = $self;
        }
    }

}

{   package My::LinkedList;

    sub new {
        my ($class, @list) = @_;
        my $top;
        while (@list) {
            my $value = pop @list;
            my $node = 'My::Node'->new($value);
            $node->attach($top) if $top;
            $top = $node;
        }
        bless { head => $top }, $class
    }

    sub head {
        my ($self, $head) = @_;
        $self->{head} = $head if @_ > 1;
        return $self->{head}
    }

    sub Values {
        my ($self) = @_;
        my $node = $self->head;
        my @values;
        while ($node) {
            push @values, $node->value;
            $node = $node->Next;
        }
        return \@values
    }

    sub partition {
        my ($self, $k) = @_;
        my $node = $self->head;
        my ($head, $tail);
        while ($node) {
            my $next = $node->disconnect;
            $node->append($node->value >= $k ? $tail : $head);
            $node = $next;
        }
        $tail->append($head) if $head && $tail;
        $_[0]{head} = $head || $tail;
    }
}

use Test::More;

my $head = 'My::Node'->new(2);
my $body = 'My::Node'->new(1);
my $list = 'My::LinkedList'->new;
$list->head($head);
$head->attach($body);

is_deeply $list->Values, [2, 1], 'values';
$list->partition(2);
is_deeply $list->Values, [1, 2], 'pair partition';


my $ll = 'My::LinkedList'->new(1, 4, 3, 2, 5, 2);
is_deeply $ll->Values, [1, 4, 3, 2, 5, 2], 'constructor args';


$ll->partition(3);
is_deeply $ll->Values, [1, 2, 2, 4, 3, 5], 'sample partition';

my $repeated = 'My::LinkedList'->new(1, 2, 3, 1, 2, 3);
$repeated->partition(2);
is_deeply $repeated->Values, [1, 1, 2, 3, 2, 3], 'repeated';

my $short = 'My::LinkedList'->new(1);
$short->partition(1);
is_deeply $short->Values, [1], 'short';

$short->partition(2);
is_deeply $short->Values, [1], 'short over';

done_testing();
