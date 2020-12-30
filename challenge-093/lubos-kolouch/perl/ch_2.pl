#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_2.pl
#
#        USAGE: ./ch_2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #093
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/
#               Sum Path
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 12/30/2020 02:39:16 PM
#===============================================================================

use strict;
use warnings;
use Moose;

package Point;
use Moose;

    has 'value' => (is => 'ro', isa=>'Int');
    has 'left' => (is => 'rw', isa=>'Point');
    has 'right' => (is => 'rw', isa=>'Point');
    has 'total_value' => (is => 'rw', isa=>'Int', default => 0);

my $total_sum = 0;

sub sum_paths{
    my $root = shift;

    $root->total_value($root->value + $root->total_value);

    if ($root->left) {
        $root->left->total_value($root->total_value);
        sum_paths($root->left);
    }

    if ($root->right) {
        $root->right->total_value($root->total_value);
        sum_paths($root->right);
    }

    if ((!defined $root->left) and (!defined $root->right)) {
            $total_sum += $root->total_value;
    }

    return $total_sum;
}

use Test::More;

my $root = Point->new( value => 1);
my $elem1 = Point->new( value => 2);

my $pos = $elem1;
$root->left($elem1);

$pos = $root->left;
$elem1 = Point->new( value => 3);
my $elem2 = Point->new( value => 4);

$pos->left($elem1);
$pos->right($elem2);

is(sum_paths($root), 13);

$total_sum = 0;
$root = Point->new( value => 1);
$elem1 = Point->new( value => 2);
$elem2 = Point->new( value => 3);

$pos = $elem1;
$root->left($elem1);
$root->right($elem2);

$pos = $root->left;
$elem1 = Point->new( value => 4);
$pos->left($elem1);

$pos = $root->right;
$elem1 = Point->new( value => 5);
$elem2 = Point->new( value => 6);

$pos->left($elem1);
$pos->right($elem2);

is(sum_paths($root), 26);

done_testing();
