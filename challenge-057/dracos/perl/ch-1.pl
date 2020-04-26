#!/usr/bin/env perl

=head1 invert_tree

A solution to task 1 of week 57 of the Perl Weekly Challenge.

=cut

use strict;
use warnings;
use Tree::DAG_Node;
use Test::More;

my $tree = Tree::DAG_Node->new({ name => 1 });
$tree->new_daughter({ name => 2 })->new_daughter({ name => 4 })->mother->new_daughter({ name => 5 });
$tree->new_daughter({ name => 3 })->new_daughter({ name => 6 })->mother->new_daughter({ name => 7 });

my $inverted = Tree::DAG_Node->new({ name => 1 });
$inverted->new_daughter({ name => 3 })->new_daughter({ name => 7 })->mother->new_daughter({ name => 6 });
$inverted->new_daughter({ name => 2 })->new_daughter({ name => 5 })->mother->new_daughter({ name => 4 });

is print_tree(invert_tree($tree)), print_tree($inverted);

done_testing;

=over

=item invert_tree

Given a Tree::DAG_Node tree of numbers, returns an inverted tree.

=cut

sub invert_tree {
    my $tree = shift;
    $tree = $tree->copy_tree if $tree->is_root;
    $tree->set_daughters(reverse $tree->daughters);
    foreach ($tree->daughters) {
        invert_tree($_);
    }
    return $tree;
}

=item print_tree

Given a Tree::DAG_Node tree, prints it out

=cut

sub print_tree {
    my $tree = shift;
    die unless $tree && $tree->isa('Tree::DAG_Node');
    return join("\n", @{$tree->draw_ascii_tree});
}

=back
