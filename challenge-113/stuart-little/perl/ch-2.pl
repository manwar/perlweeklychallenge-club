#!/usr/bin/perl
use warnings;
use v5.12;

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::AllUtils qw(first sum);
use Tree::DAG_Node;

sub diffIfNum($nr,$str) {
    return ($str =~ /^\d+$/) ? ($nr - int($str)) : ($str);
}

sub moreDots($a) {
    return 2*(scalar grep {$_ eq "."} @{$a}) > (scalar @{$a});
}

sub ixSplit($a) {
    return first { my @ar = $a->@[0..$_]; moreDots(\@ar) } (keys @{$a});
}

sub treeList2Hash($t) {
    (! scalar @{$t} || $t->[0] eq '.') && return {};
    my @rest = @{$t}[1..scalar @{$t}-1];
    my $ix = ixSplit(\@rest);
    my @left = @rest[0..$ix];
    my @right = @rest[$ix+1..$#rest];
    return {
	name => $t->[0],
	left => treeList2Hash(\@left),
	right => treeList2Hash(\@right),
    };
}

sub mkDAG($h) {
    (! scalar keys %{$h}) && return Tree::DAG_Node->new({ name => "" });
    my $root = Tree::DAG_Node->new({ name => $h->{name} });
    my %left = %{$h->{left}};
    $root->add_daughter(mkDAG(\%left));
    my %right = %{$h->{right}};
    $root->add_daughter(mkDAG(\%right));
    return $root;
}

my @INPUT = (scalar @ARGV) ? (@ARGV) : (qw(1 2 4 . 7 . . . 3 5 . . 6 . .));
my $sum = sum grep {$_ =~ /^\d+$/} @INPUT;
my @outTreeList = map {diffIfNum($sum,$_)} @INPUT;
my $tree = mkDAG(treeList2Hash(\@outTreeList));

print map("$_\n", @{$tree->tree2string({no_attributes => 1})});

__END__
run <script> <tree in preorder form with '.' for empty nodes, entered as space-separated values>

ref: https://stackoverflow.com/a/2676849/11064961

e.g. 1 2 4 . 7 . . . 3 5 . . 6 . . represents the tree

        1
       / \
      2   3
     /   / \
    4   5   6
     \
      7

given as an example in the problem formulation at https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2
