#!/usr/bin/env perl
# Perl weekly challenge 094
# Task 2: Binary tree to linked list.
#
# See https://wlmb.github.io/2021/01/04/PWC94/#task-1-binary-tree-to-linked-list
use v5.12;
use Text::Balanced qw(extract_bracketed extract_multiple);

package Tree;
use Moose;
has value=>(is=>'ro', required=>1);
has left=>(is=>'ro', required=>1);
has right=>(is=>'ro', required=>1);

sub flatten {
    my $self=shift;
    return () unless defined $self->value;
    return ($self->value, $self->left?$self->left->flatten:(), $self->right?$self->right->flatten:());
}

package main;
foreach(@ARGV){
    # remove unnecesary commas
    tr/,//d;
    my $tree=build_tree($_);
    say("Empty tree"), next unless defined $tree;
    my @values=$tree->flatten;
    say join '->', @values;
}

sub build_tree { #Build tree recursively from string representation
    my $string=shift @_;
    # strip parenthesis
    die "Wrong format of string $string" unless $string=~s/^\s*\((.*)\)\s*$/$1/;
    return undef if $string=~/^\s*$/; # empty tree
    my @parts=extract_multiple($string,[\&extract_bracketed]);
    die "Not a binary tree ", join " ",@parts unless @parts==3;
    my($value, $left, $right)=@parts;
    die "Value can contain only alphanumerics: $value" unless $value=~s/^\s*(\w+)\s*$/$1/;
    return Tree->new(value=>$value, left=> build_tree($left), right=>build_tree($right));
}
