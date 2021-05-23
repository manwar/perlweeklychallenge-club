#!/usr/bin/env perl

my $copyright = <<'COPYRIGHT';
# Copyright (c) 2021 by Christian Jaeger <copying@christianjaeger.ch>
# This is free software. See the file COPYING.md that came bundled
# with this file.
COPYRIGHT

=pod

L<The Weekly Challenge - 113|https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/>,
TASK #2: Recreate Binary Tree

You are given a Binary Tree.

Write a script to replace each node of the tree with the sum of all the remaining nodes.

=head1 NOTE

There is a L<blog post about this|http://functional-perl.org/docs/blog/perl-weekly-challenges-113.xhtml>.

=cut

use strict;
use utf8;
use warnings;
use warnings FATAL => 'uninitialized';
use experimental 'signatures';

my ($mydir, $myname);

BEGIN {
    $0 =~ /(.*?)([^\/]+)\z/s or die "?";
    ($mydir, $myname) = ($1, $2);
}
use lib "$mydir/../../lib";

use FP::Docstring;
use Chj::TEST ":all";
use FP::Equal;

package PFLANZE::Node {
    use FP::Predicates qw(is_string maybe instance_of);
    *is_maybe_Node = maybe instance_of("PFLANZE::Node");

    use FP::Struct [
        [\&is_maybe_Node, "left"],
        [\&is_string,     "value"],
        [\&is_maybe_Node, "right"]
    ] => ("FP::Struct::Show", "FP::Struct::Equal");

    sub map ($self, $fn) {
        my $l  = $self->left;
        my $r  = $self->right;
        my $l2 = defined($l) ? $l->map($fn) : undef;
        my $r2 = defined($r) ? $r->map($fn) : undef;
        $fn->($l2, $self->value, $r2)
    }

    _END_
}
PFLANZE::Node::constructors->import;

my $in = Node(Node(Node(undef, 4, Node(undef, 7, undef)), 2, undef),
    1, Node(Node(undef, 5, undef), 3, Node(undef, 6, undef)));

TEST { equal $in, $in->map(\&Node) } 1;

sub tree_sum($t) {
    $t->map(
        sub ($l, $value, $r) {
            $value + ($l // 0) + ($r // 0)
        }
    )
}

TEST { tree_sum $in } 28;

sub tree_recreate($t) {
    my $sum = tree_sum($t);
    $t->map(
        sub ($l, $value, $r) {
            Node($l, $sum - $value, $r)
        }
    )
}

TEST { tree_recreate $in }
Node(Node(Node(undef, 24, Node(undef, 21, undef)), 26, undef),
    27, Node(Node(undef, 23, undef), 25, Node(undef, 22, undef)));

# ----------------------------------------------------------------------

sub help {
    print "Usage: $0 --repl | --test\n";
    exit 1
}

&{
    @ARGV
    ? {
        "--repl" => sub {
            require FP::Repl::Trap;
            FP::Repl::repl();
        },
        "--test" => sub {
            run_tests __PACKAGE__;
        }
        }->{ $ARGV[0] } // \&help
    : \&help
};

