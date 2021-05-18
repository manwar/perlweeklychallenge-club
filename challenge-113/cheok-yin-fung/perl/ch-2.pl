#!/usr/bin/perl
# The Weekly Challenge 113
# Task 2 Recreate Binary Tree
use strict;
use warnings;
use Data::Dumper; # use for print_pretty_tree

die <<FOO
Incorrect input format.
Usage: ch-2.pl [binary tree in array format, \'x\' for null nodes]
for example, \$ ch-2.pl 2 3 5 x 7

    2 
   / \\
  3   5
   \\
    7
FOO
    unless consistency(@ARGV);

my @tree = map { $_ eq 'x' ? undef : $_ } @ARGV;

my $sum = 0;

for (@tree) {
    $sum += $_ if defined($_);
}

for (@tree) {
    $_ = $sum - $_ if defined($_);
}

print_tree(@tree);
print_pretty_tree(@tree);


sub consistency {
    my @t = @_;
    return 0 if !defined($t[0]) || ($t[0] !~ /^\d+$/ && $t[0] ne 'x');
    for my $ind (1..$#t) { 
        if ($t[$ind] =~ /^\d+$/) {
            if ($t[($ind-1)/2] eq 'x') {
                return 0;
            }
        } 
        else {
            return 0 if $t[$ind] ne 'x';
        }
    }
    return 1;
}

sub print_tree {
    print "Output in Array Format:\n";
    for my $v (@_) {
        if (defined($v)) {
            print $v, " ";
        } 
        else {
            print 'x', " ";
        }
    }
    print "\n";
}




sub print_pretty_tree {
    my @tr = @_;
    my $hash_tree = tree_build( \@tr, 0);

    $Data::Dumper::Terse = 1; 
    $Data::Dumper::Indent = 2;
    $Data::Dumper::Sortkeys = 1;
    print "\n"; 
    print "Output in Hash Format:\n";
    print Dumper $hash_tree; 
}

sub tree_build {        # use for print_pretty_tree
    my @t = @{$_[0]};
    my $ind = $_[1]; 
    my %leaf = ( "v" => $t[$ind] );
    $leaf{"l"} = tree_build(\@t, $ind*2+1) if defined($t[$ind*2+1]);
    $leaf{"r"} = tree_build(\@t, $ind*2+2) if defined($t[$ind*2+2]);
    return \%leaf;
}
