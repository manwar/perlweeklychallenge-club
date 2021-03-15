#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_2.pl
#
#        USAGE: ./ch_2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #094
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-094/
#               Binary Tree to Linked List
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 01/06/2021 02:39:16 PM
#===============================================================================

use strict;
use warnings;
use Moose;

{
package Point;
use Moose;

    has 'value' => (is => 'ro', isa=>'Int');
    has 'left' => (is => 'rw', isa=>'Point');
    has 'right' => (is => 'rw', isa=>'Point');
}

{
package SumPath;
use Moose;

    has 'total_path' => (is => 'rw', isa => 'ArrayRef', default => sub { [] });

    sub walk_path{
        my $self = shift;
        my $root = shift;

        push @{$self->total_path}, $root->value;

        if ($root->left) {
            $self->walk_path($root->left);
        }

        if ($root->right) {
            $self->walk_path($root->right);
        }

        return $self->total_path;
    }
}

no Moose;
use Test::More;

# TEST 1
my $root = Point->new(value => 1);
my $elem1 = Point->new(value => 2);

my $pos = $elem1;
$root->left($elem1);

$pos = $root->left;
$elem1 = Point->new(value => 3);
my $elem2 = Point->new(value => 4);

$pos->left($elem1);
$pos->right($elem2);

my $sumpath = SumPath->new;
my $arr = $sumpath->walk_path($root);
is_deeply($arr, [1, 2, 3, 4]);

# TEST 2

$root = Point->new(value => 1);
$elem1 = Point->new(value => 2);
$elem2 = Point->new(value => 3);
$root->left($elem1);
$root->right($elem2);

$pos = $root->left;
$elem1 = Point->new(value => 4);
$elem2 = Point->new(value => 5);
$pos->left($elem1);
$pos->right($elem2);

$pos = $pos->right;
$elem1 = Point->new(value => 6);
$elem2 = Point->new(value => 7);

$pos->left($elem1);
$pos->right($elem2);

$sumpath = SumPath->new;
$arr = $sumpath->walk_path($root);
is_deeply($arr, [1, 2, 4, 5, 6, 7, 3]);
my $res_str = join ' -> ', @$arr;

print "$res_str\n";

done_testing();
