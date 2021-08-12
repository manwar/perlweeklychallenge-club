#!/usr/bin/env perl

use Tree::Binary;
use Modern::Perl;
use List::Util 'max';

=begin example1
    1
   / \
  2   5
 / \ / \
3  4 6  7
       / \
      8  10
     /
    9
=end example1
=cut

my $example1 = Tree::Binary->new('1')
                           ->setLeft(Tree::Binary->new('2')
                           ->setLeft(Tree::Binary->new('3'))
                           ->setRight(Tree::Binary->new('4')))
                           ->setRight(Tree::Binary->new('5')
                           ->setLeft(Tree::Binary->new('6'))
                           ->setRight(Tree::Binary->new('7')
                           ->setLeft(Tree::Binary->new('8')
                           ->setLeft(Tree::Binary->new('9')))
                           ->setRight(Tree::Binary->new('10'))));

say treeDiameter($example1); # 6

sub treeDiameter
{
    my $btree = shift;
    my @diameters;

    $btree->traverse
    (
        sub
        {
            my ($tree) = @_;

            my $leftHeight  = 0;
            my $rightHeight = 0;
 
            if ($tree->hasLeft)
            {
                $leftHeight = $tree->getLeft->height;
            }  

            if ($tree->hasRight)
            {
                $rightHeight = $tree->getRight->height;
            }

            push @diameters, $leftHeight + $rightHeight;
        }
    );

    max @diameters;
}
