# The Weekly Challenge 242
# Task 1 Missing Members
use v5.30.0;
use warnings;
use List::Util qw/uniqint/;

sub mm {
    my @arr1 = $_[0]->@*;
    my @arr2 = $_[1]->@*;
    my @brr1 = uniqint @arr1;
    my @brr2 = uniqint @arr2;
    my @commons;
    for my $e1 (@brr1) {
        for my $e2 (@brr2) {
            push @commons, $e1 if $e1 == $e2;
        }
    }
    @commons = uniqint @commons;
    # @commons = sort {$a<=>$b} @commons;
    # @brr1 = sort {$a<=>$b} @brr1;
    # @brr2 = sort {$a<=>$b} @brr2;
    return [
      [grep {!contains([@commons], $_)} @brr1],
      [grep {!contains([@commons], $_)} @brr2],
    ];
}

sub contains {
    my @arr = $_[0]->@*;
    my $i = $_[1];
    for (@arr) {
        return 1 if $_ == $i;
    }
    return 0;
}

use Data::Printer;
my $ex1 = mm([1,2,3], [2,4,6]);
p $ex1;
my $ex2 = mm([1,2,3,3], [1,1,2,2]);
p $ex2;
