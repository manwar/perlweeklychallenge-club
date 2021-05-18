#!/usr/bin/env perl6
use v6;

use MONKEY-SEE-NO-EVAL;

sub diffIfNum($nr,$str) {
    return ($str.Int.defined) ?? (($nr - $str.Int).Str) !! ($str);
}

sub list2lol(@l) {
    (@l.elems == 0 || @l[0] eq '.') && return [""];
    my $ix = @l[1..*].keys.first( -> $i { 2*@l[1..$i+1].grep({ $_ eq '.' }).elems > $i+1});
    return [list2lol(@l[1..$ix+1]),list2lol(@l[$ix+2..*]),@l[0].Str];
}

my @INPUT = (@*ARGS.elems) ?? (@*ARGS) !! (<1 2 4 . 7 . . . 3 5 . . 6 . .>);
my $sum = @INPUT.grep({ $_.Int.defined }).map(*.Int).sum;
my @outTreeList = @INPUT.map({ diffIfNum($sum,$_) });

my $str=list2lol(@outTreeList).raku;
EVAL qq!
use Tree::DAG_Node;
my \$lol = $str;
my \$tree=Tree::DAG_Node->lol_to_tree(\$lol);
print map(\"\$_\\n\", \@\{\$tree->tree2string(\{ no_attributes => 1 \})\}); 
!, :lang<Perl5>;

=finish
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
