#!/usr/bin/env perl
# Perl weekly challenge 125
# Task 1:  Binary tree diameter
#
# See https://wlmb.github.io/2021/08/10/PWC125/#task-2-binary-tree-diameter
use warnings;
use strict;
use v5.12;
use List::Util qw(max);

foreach(@ARGV){
    die("Only []0-9, and spaces allowed") unless m/^([][0-9,\s])*$/;
    my $tree_as_array=eval $_;
    warn("eval failed @!"), next if @!;
    my $tree_as_hash=make_tree($tree_as_array);
    my @path=(reverse(path($tree_as_hash->{head}{left})), $tree_as_hash->{head}{value},
	      path($tree_as_hash->{head}{right}));
    say "Input: $_\nDiameter: $tree_as_hash->{diameter}\nPath: ",
        join "-", @path;
}
sub make_tree {
    my $array=shift;
    my %node;
    die "Wrong format" unless ref($array) eq "ARRAY";
    return undef if @$array==0;
    my $value=$array->[0];
    my ($left,$right)=map {make_tree($_)} map {$array->[$_]} (1,2);
    my ($dl, $dr)=map {defined $_?$_->{depth}+1:0} ($left, $right);
    my $depth=max ($dl, $dr);
    my $deepest=$depth==$dl?$left:$right;
    my ($Dl, $Dr)=map {defined $_?$_->{diameter}:0} ($left, $right);
    my $D=(defined $left?$dl:0)+(defined $right?$dr:0)+1;
    my $diameter=max($D, $Dl, $Dr);
    my $head=$diameter==$D?\%node # self reference or
             :$diameter==$dl?$left->{head} # reference to child
             :$right->{head};
    @node{qw(value left right depth deepest diameter head)} # Build the node
    =($value,$left,$right,$depth,$deepest,$diameter,$head);
    return \%node;
}

sub path {
    my $tree=shift;
    return () unless defined $tree;
    return ($tree->{value},path($tree->{deepest}));
}
