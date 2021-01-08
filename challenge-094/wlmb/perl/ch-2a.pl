#!/usr/bin/env perl
# Perl weekly challenge 094
# Task 2: Binary tree to linked list.
#
# See https:/wlmb.github.io/2020/01/04/PWC94/#task-1-binary-tree-to-linked-list
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
foreach(@ARGV){ # for each yaml file
    my $yaml=YAML::Tiny->read($_);
    foreach(@{$yaml}){ #for each document in the file
	my $tree=build_tree($_);
	die "Empty tree" unless defined $tree;
	my @values=$tree->flatten;
	say join '->', @values;
    }
}

sub build_tree { #Build tree recursively
    my $tree=shift;
    return undef unless defined $tree; #Empty tree
    return Tree->new(value=>$tree, left=>undef, right=>undef) unless ref $tree; # a leave
    # Die with a unsophisticated dump of the current subtree in case of errors
    die "Not a binary tree\n". Dumper($tree) unless ref $tree eq "HASH";
    my @keys=keys %{$tree};
    die "Not a binary tree\n". Dumper($tree) unless @keys==1;
    my $value=$keys[0]; # Confusingly, value of node is the key of the hash!
    my $subtrees=$tree->{$value}; # and value of hash is array of subtrees
    die "Not a binary tree\n". Dumper($tree) unless ref $subtrees eq "ARRAY" and @$subtrees==2;
    my ($left,$right)=@$subtrees;
    return Tree->new(value=>$value, left=> build_tree($left), right=>build_tree($right));
}
