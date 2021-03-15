#!/usr/bin/env perl
# Perl weekly challenge 094
# Task 2: Binary tree to linked list.
#
# See https://wlmb.github.io/2021/01/04/PWC94/#task-1-binary-tree-to-linked-list
use v5.12;

package Tree;
use Moose;
has value=>(is=>'ro', required=>1);
has left=>(is=>'ro', required=>1);
has right=>(is=>'ro', required=>1);

sub flatten {
    my $self=shift;
    return () unless defined $self->value;
    return ($self->value,
	    $self->left?$self->left->flatten:(),
	    $self->right?$self->right->flatten:());
}

package main;
use Data::Dumper;
use YAML::Tiny;
# @ARGV contains yaml filenames
foreach(@ARGV){ # for each yaml file
    my $yaml=YAML::Tiny->read($_); # convert yaml document to perl structure
    foreach(@{$yaml}){ #for each document in the file
	my $tree=build_tree($_);
	say("Empty tree"), next unless defined $tree;
	my @values=$tree->flatten;
	say join '->', @values;
    }
}

sub build_tree { #Build tree recursively
    my $tree=shift;
    return undef unless defined $tree; #Empty tree
    return Tree->new(value=>$tree, left=>undef, right=>undef) unless ref $tree; # a leaf
    # Die with an unsophisticated dump of the current subtree in case of errors
    die "Not a binary tree\n". Dumper($tree) unless ref $tree eq "HASH";
    my @keys=keys %{$tree};
    die "Not a binary tree\n". Dumper($tree) unless @keys==1;
    my $node=$keys[0];
    my $subtrees=$tree->{$node};
    die "Not a binary tree\n". Dumper($tree) unless ref $subtrees eq "ARRAY" and @$subtrees==2;
    my ($left,$right)=@$subtrees;
    return Tree->new(value=>$node, left=> build_tree($left), right=>build_tree($right));
}
