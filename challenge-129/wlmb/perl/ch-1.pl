#!/usr/bin/env perl
# Perl weekly challenge 129
# Task 1:  root distance
#
# See https://wlmb.github.io/2021/09/06/PWC129/#task-1-root-distance
use warnings;
use strict;
use v5.12;
# use Data::Dumper;

my %root_distance; # hash of depths indexed by the node values.
# my $tree=   # Throw away the actual tree, as it is not used
analyze_tree(-1,-1); # initialize indentation and depth.
# say Dumper($tree); # For debugging
say "Value: $_ Depth: ", $root_distance{$_}//"Not defined" for @ARGV;

sub analyze_tree {
    my ($previous_indent, $depth)=@_;
    ++$depth;
    my ($current_indent, $value)=analyze_line($previous_indent);
    # If I found a node at the correct indentation, build a tree structure
    $root_distance{$value}=$depth, #
        return {value=>$value,
            left=>analyze_tree($current_indent,$depth),
            right=>analyze_tree($current_indent,$depth)}
        if defined $current_indent && defined $value && $value ne '';
    return undef;
}

sub analyze_line {
# Read and analyze lines. Keep them until their turn if outdented
    state ($line, $current_indent, $value);
    my $previous_indent=shift;
    if(!defined $current_indent){
	$line=<STDIN>;
	return () if !defined $line || $line=~m/^\s*$/;
	die "Malformed tree: $line" unless $line=~m/^(\s*)-\s*(\d*)\s*$/;
	$current_indent=length $1;
	$value=$2;
    }
    if($current_indent>$previous_indent){
	my $result_indent=$current_indent;
	$current_indent=undef;
	return ($result_indent, $value);
    }
    return ();
}
