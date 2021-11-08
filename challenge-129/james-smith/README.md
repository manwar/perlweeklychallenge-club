# Perl Weekly Challenge #129

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-129/james-smith/perl

# Task 1 -  Root Distance

***You are given a tree and a node of the given tree. Write a script to find out the distance of the given node from the root.***

## The solution

By modifying our BinaryTree object from previous exercise by adding the ancestor to the object to the object as well as the child (yes I know there is garbage collection issue here with reference counting) but I haven't built a remove node function yet! In true object way this is the best option (there are other ways you can achieve this if you have a way to enumerate all nodes - e.g. Celko's nested sets)

```perl

## Object is an arrayref [ value, left child, right child, parent ]
sub add_child_left {
  my( $self,$child ) = @_;
  $self->[1] = $child;
  $child->[3] = $self;
  return $self;
}

sub add_child_right {
  my( $self,$child ) = @_;
  $self->[2] = $child;
  $child->[3] = $self;
  return $self;
}

sub parent {
  my $self = shift;
  return $self->[3];
}

sub has_parent {
  my $self = shift;
  return defined $self->[3];
}

```

This then becomes a case of working up the tree to pick out the ancestors and return the length. This function returns the ancestors - calling scalar on the result gives the distance.

```perl
sub ancestors {
  my $self = shift;
  my $x = $self;
  my @ancestors;
  while($x->has_parent) {
    push @ancestors, $x;
    $x = $x->parent;
  }
  return @ancestors;
}
```

# Task 2 - Add Linked Lists

***You are given two linked list having single digit positive numbers. Write a script to add the two linked list and create a new linked representing the sum of the two linked list numbers. The two linked lists may or may not have the same number of elements.***

## Solution

We again use our LL module from previous challenges.

We create our two input lists - and then start building our output list. The module doesn't allow empty lists - so we start by creating the first node.
We then work our way along each list using next which moves from 1 node to the next - add adding a new node to the list

```perl
my $ch1 = LL->new( 1 )->add( 3 )->add( 2 );
my $ch2 = LL->new( 3 )->add( 1 )->add( 2 );

my $ch3 = LL->new( $ch1->val + $ch2->val ); ## Create the first node of the new tree.
my ( $p1, $p2 ) = ( $ch1, $ch2 ); ## Make "pointers" to the trees we will later
                                  ## move these forward an entry at a time

while( 1 ) {
  $p1 = $p1->next;
  last unless $p1;
  $p2 = $p2->next;
  $ch3->add( $p1->val + $p2->val ); ## add to end of LL
}

say join "   ", $ch3->flatten;
```
