#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package Eertree::Node;
    use Moo;

    has length => (is => 'ro',  required => 1);
    has pos    => (is => 'rwp', required => 1);
    has link   => (is => 'rw');
    has edge   => (is => 'lazy', builder => sub { {} }, predicate => 1);

    sub string {
        my ($self, $eertree) = @_;
        return substr $eertree->string, $self->pos, $self->length
    }
}

{   package Eertree;
    use Moo;

    has nodes => (is => 'ro', default => sub { [
        'Eertree::Node'->new(link => 0, length => -1, pos => -1),
        'Eertree::Node'->new(link => 0, length =>  0, pos =>  0)
    ]});
    has string => (is => 'ro');
    has max    => (is => 'rw', default => 0);

    sub node {
        my ($self, $index) = @_;
        return $self->nodes->[$index]
    }

    sub at {
        my ($self, $pos) = @_;
        return substr $self->string, $pos, 1
    }

    sub build {
        my ($self) = @_;
        my $i = 0;
        $self->add($i++, $_) for split //, $self->string;
    }

    sub Push {
        my ($self, $node) = @_;
        push @{ $self->nodes }, $node;
    }

    sub Last { $#{ $_[0]->nodes } }

    sub add {
        my ($self, $index, $char) = @_;

        my $new_node;
        my $p = $self->max;
        while ($self->node($p)) {
            my $node = $self->node($p);
            my $pos = $node->length == -1
                    ? $index
                    : $index - $node->length - 1;
            if ($pos >= 0 && $self->at($pos) eq $char) {
                if (exists $node->edge->{$char}) {
                    $new_node = $self->node($node->edge->{$char});
                    $self->max($node->edge->{$char});
                    return
                }
                $new_node = 'Eertree::Node'->new(pos    => $pos,
                                                 length => $index - $pos + 1);
                $node->edge->{$char} = $self->Last + 1;
                last
            }
            $p = $node->link;
        }

        $self->Push($new_node);
        $self->max($self->Last);

        if ($new_node->length == 1) {
            $new_node->link(1);
            return
        }

        my $q = $self->node($p)->link;
        while ($self->node($p)) {
            my $pos = $self->node($q)->length == -1
                    ? $index
                    : $index - $self->node($q)->length - 1;
            if ($pos >= 0 && $self->at($pos) eq $char) {
                $new_node->link($self->node($q)->edge->{$char});
                last
            }
            $q = $self->node($q)->link;
        }
    }

    sub to_dot {
        my ($self) = @_;
        say 'digraph { rankdir = BT;';
        for my $i (0 .. $self->Last) {
            my $node = $self->node($i);
            say $i, qq([shape=record, label="$i|),
                $node->string($self) || $i - 1, '"]';
            say $i, '->', $node->link, '[color=blue]';
        }
        for my $i (0 .. $self->Last) {
            my $node = $self->node($i);
            for my $ch (keys %{ $node->edge }) {
                say $i, '->', $node->edge->{$ch},
                    "[label=$ch, constraint=false]";
            }
        }
        say '}';
    }
}


use Test2::V0;

{   my $e = 'Eertree'->new(string => 'a');
    $e->build;
    is $e->Last, 2, 'size';
    is $e->nodes->[0]->edge, {a => 2}, 'edge -1->a';
    is $e->nodes->[2]->link, 1, 'link a->1';
    is $e->nodes->[2]->string($e), 'a', 'string a';
}
{   my $e = 'Eertree'->new(string => 'aa');
    $e->build;
    is $e->Last, 3, 'size';
    is $e->nodes->[0]->edge, {a => 2}, 'edge -1->a';
    is $e->nodes->[1]->edge, {a => 3}, 'edge 0->aa';
    is $e->nodes->[2]->string($e), 'a', 'string a';
    is $e->nodes->[2]->link, 1, 'link';
    is $e->nodes->[3]->string($e), 'aa', 'string aa';
    is $e->nodes->[3]->link, 2, 'link aa->a';
}


{   my $e = 'Eertree'->new(string => 'eertree');
    $e->build;

    is scalar @{ $e->nodes }, 9, 'size';

    is $e->nodes->[0]->edge, {e => 2, r => 4, t => 5}, 'edges from -1';

    is $e->nodes->[1]->edge, {e => 3}, 'edge from 0';

    is $e->nodes->[2]->edge, {}, 'no edges from e';
    is $e->nodes->[2]->link, 1, 'link e->0';
    is $e->nodes->[2]->pos, 0, 'pos e';
    is $e->nodes->[2]->string($e), 'e', 'string e';

    is $e->nodes->[3]->edge, {}, 'no edges from "ee"';
    is $e->nodes->[3]->link, 2, 'link ee->e';
    is $e->nodes->[3]->pos, 0, 'pos ee';
    is $e->nodes->[3]->string($e), 'ee', 'string ee';

    is $e->nodes->[4]->edge, {}, 'no edges from r';
    is $e->nodes->[4]->link, 1, 'link r->0';
    is $e->nodes->[4]->pos, 2, 'pos r';
    is $e->nodes->[4]->string($e), 'r', 'string r';

    is $e->nodes->[5]->edge, {r => 6}, 'edge t->rtr';
    is $e->nodes->[5]->link, 1, 'link t->0';
    is $e->nodes->[5]->pos, 3, 'pos t';
    is $e->nodes->[5]->string($e), 't', 'string t';

    is $e->nodes->[6]->edge, {e => 7}, 'edge rtr->ertre';
    is $e->nodes->[6]->link, 4, 'link rtr->r';
    is $e->nodes->[6]->pos, 2, 'pos rtr';
    is $e->nodes->[6]->string($e), 'rtr', 'string rtr';

    is $e->nodes->[7]->edge, {e => 8}, 'edge ertre->eertree';
    is $e->nodes->[7]->link, 2, 'link ertre->e';
    is $e->nodes->[7]->pos, 1, 'pos ertre';
    is $e->nodes->[7]->string($e), 'ertre', 'string ertre';

    is $e->nodes->[8]->edge, {}, 'no edges from eertree';
    is $e->nodes->[8]->link, 3, 'link eertree->ee';
    is $e->nodes->[8]->pos, 0, 'pos eertree';
    is $e->nodes->[8]->string($e), 'eertree', 'string eertree';
}

my @examples = (
    [redivider => qw[ r redivider e edivide d divid i ivi v ]],
    [deific    => qw[ d e i ifi f c ]],
    [rotors    => qw[ r rotor o oto t s ]],
    [challenge => qw[ c h a l ll e n g ]],
    [champion  => qw[ c h a m p i o n ]],
    [christmas => qw[ c h r i s t m a ]],
    [abbcabc   => qw[ a b c bb ]],
    [xabcxc    => qw[ x a b c cxc ]],
);

my $i = 1;
for my $example (@examples) {
    my $tree = 'Eertree'->new(string => $example->[0]);
    $tree->build;
    is [grep length, map $_->string($tree), @{ $tree->nodes }],
        bag { item($_) for @$example[1 .. $#$example]; end() },
        "Example " . $i++;
}

done_testing();
