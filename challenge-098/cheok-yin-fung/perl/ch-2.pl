#!/usr/bin/perl
# The Weekly Challenge 098
# Task 2 Search Insert Position
use strict;
use warnings;
use Test::Simple tests => 7;

{  # modified from codes in The Weekly Challenge 094
use strict;
package BTNode;

sub new {
    my ($class) = @_;
    bless {
        _value => $_[1],
        _leftchild => $_[2],
        _rightchild => $_[3],
        _order => $_[4],
    }, $class;
}

sub value { $_[0]->{_value} }
sub leftchild { $_[0]->{_leftchild} }
sub rightchild { $_[0]->{_rightchild} }
sub order { $_[0]->{_order} }

sub set_value { $_[0]->{_value} = $_[1]; }
sub set_order { $_[0]->{_order} = $_[1]; }
sub set_leftchild { $_[0]->{_leftchild} = $_[1]; }
sub set_rightchild { $_[0]->{_rightchild} = $_[1]; }

sub search {
    my $aRoot = $_[0];
    my $target = $_[1];
    if ($target == ($aRoot->value)) {
        return $aRoot->order;
    } elsif ( $aRoot->value > $target ) {
        if (defined($aRoot->leftchild->value)) {
            return $aRoot->leftchild->search($target);
        } else {
            return ($aRoot->order);
        }
    } elsif ( $aRoot->value < $target ) {
        if (defined($aRoot->rightchild->value)) {
            return $aRoot->rightchild->search($target);
        } else {
            return ($aRoot->order + 1);
        }
    }
}


# codes reference to:
# https://stackoverflow.com/questions/
# 19399747/insert-sorted-array-into-binary-search-tree

sub insert {       

    my $aRoot = $_[0];
    my @sorted_stuff = @{$_[1]};
    my $start = $_[2];
    my $end = $_[3];

    if ($start > $end) {
        return undef;
    }

    my $mid = $start +  int(($end-$start)/2);
    $aRoot->set_value($sorted_stuff[$mid]);
    $aRoot->set_order($mid);
    

    $aRoot->set_leftchild(BTNode->new(undef, undef, undef, undef));
    $aRoot->set_rightchild(BTNode->new(undef, undef, undef, undef));
    $aRoot->leftchild->insert( \@sorted_stuff, $start, $mid-1 );
    $aRoot->rightchild->insert( \@sorted_stuff, $mid+1, $end );

    return $aRoot;
}

}; # END of package BTNode


sub search {
    my $N = $_[0];
    my @arr = @{$_[1]};
    my $temp = $#arr;
    my $treeroot = BTNode->new( $arr[int($temp/2)] , 
                    undef, undef, int($temp/2))      ;
    $treeroot->insert(\@arr, 0, $#arr);
    return $treeroot->search($N);
}



my @primes = (2, 3, 5, 7, 11, 13, 17, 19, 23);
my @even = (2, 4, 6, 8, 10, 12, 14);
my @triangular = (1, 3, 6, 10, 15, 21, 28);

ok ( search(29, \@primes) == 9, "Test 1"  ) ;
ok ( search(3, \@even) == 1, "Test 2" );
ok ( search(7, \@triangular) == 3, "Test 3") ;
ok ( search(3, [1, 2, 3, 4]) == 2, "Example 1") ;
ok ( search(6, [1, 3, 5, 7]) == 3, "Example 2") ;
ok ( search(10, [12, 14, 16, 18]) == 0, "Example 3") ;
ok ( search(19, [11, 13, 15, 17]) == 4, "Example 4") ;
