# Perl Weekly Challenge #113

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-113/james-smith/perl

# Challenge 1 - Represent Integer

**You are given a positive integer `$N` and a digit `$D`. Write a script to
check if $N can be represented as a sum of positive integers having `$D` at
least once. If check passes print `1` otherwise `0`.**

**Assumption** although not clear in the question, we make the
assumption that the numbers in the sum are all unique.

## Solution...

There are two classes of solution to this problem:

 1. Solutions where `$D` only appears in the right hand column.
 1. Solutions where `$D` appears in more than one column.

### Type 2 solutions...
If `$D` is 0. Then we can find solutions for all numbers `>=100`. For
the numbers `100` -> `109` the number itself surfices. For numbers
`>=110` we can always find a solution of the form (or similar):

```
   x x x x 0 x
+          x 0
```

If `$D` in not 0. Then we can find similar solutions for all numbers
`>= 10*$D`. Again for `10*$D` -> `10*$D + 9` the number itself surfices.
For numbers `>=11*$D` we have similar solutions to above where we can
write the nubmer as:

```
   x x x x D x
+          x D
```

So we check for that first, then we can look at the type (1) solutions

### Type 1 solutions...

We need a sequence of numbers `$D`, `10+$D`, `20+$D`, `30+$D` *etc*
that is less than or equal to `$N` and has the same last digit as `$N`.
Now we note `$D + 10+$D + 20+$D + 30+$D + 40+$D` is `100 + 5$D` and so
we know this is possible to represent for all values of `$D` so we
can ignore this case.

## Perl code

The first pass at this uses a for loop to generate the values of the
numbers in the sum. After first checking the criteria for type 2
solutions...

```perl
sub represent {
  my( $t, $n, $d ) = ( 0, @_ );
  return 1 if $n >= 10 * ( $d || 10 );
  $n >= ( $t += $_ * 10 + $d ) &&
    ( $n % 10 == $t % 10 ) && return 1 for 0..3;
  0;
}
```

We can further improve performance by removing the need for the `$t`
variable and the `for` loop by "unrolling" the loop as below...

```perl
sub represent_unrolled {
  my( $n, $d ) = @_;
  $n >= 10 * ( $d || 10 )                      ||
  $n >= $d                && $n%10 == $d       ||
  $n >= 2*$d+10           && !( ($n-2*$d)%10 ) ||
  $n >= 3*$d+30           && !( ($n-3*$d)%10 ) ||
  $n >= 4*$d+60           && !( ($n-4*$d)%10 ) ? 1 : 0;
}
```

This appears to be 50% faster than the loop solution...

# Challenge 2 - Recreate Binary Tree

**You are given a Binary Tree. Write a script to replace each
node of the tree with the sum of all the remaining nodes.**

We already have an embryonic `Tree` object from the Linked list/tree
challenge in week 94.

So we will extend this (and to write a true `BinaryTree`) representation.

## Walk the tree

For each of the problems cloning, summing, updating a tree we need to
walk the tree. The solution I propose here will define a "walking"
function on the tree, which has it's parameters:

  * a function to handle each node
  * a "global" storage object
  * a "local" storage object
  * whether the node is a left child / right child.

## Perl `BinaryTree` object.

Our binary tree is represented by an array of length 3. The value of
the node {which can be any object} and the left and right children.

We then have two methods - `add_left_child` and `add_right_child` to
add them to the tree.

We also have accessors:

 * `left` - left child
 * `right` - right child
 * `value` - value of node

We have to functions to check for existance of a child:

 * `has_left` - left child
 * `has_right` - right child

and finally a method to update a node `update`

```perl
package BinaryTree;

sub new {
  my $class = shift;
  my $value = shift;
  my $self = [ $value, undef, undef ];
  bless $self, $class;
}

sub update {
  my( $self, $val ) = @_;
  $self->[0] = $val;
  return $self;
}

sub value {
  my $self = shift;
  return $self->[0];
}

sub add_child_left {
  my( $self,$child ) = @_;
  $self->[1] = $child;
  return $self;
}

sub add_child_right {
  my( $self,$child ) = @_;
  $self->[2] = $child;
  return $self;
}

sub left {
  my $self = shift;
  return $self->[1];
}

sub right {
  my $self = shift;
  return $self->[2];
}

sub has_left {
  my $self = shift;
  return defined $self->[1];
}

sub has_right {
  my $self = shift;
  return defined $self->[2];
}

```

## Walking the tree...

Our tree walking function takes up to 4 parameters:

 1. `$fn` a callback function which does whatever is needed,
    e.g. collect summary statistics, update the node etc;
 1. `$global` a reference to a variable which is used as
    "global" storage for the walk
 1. `$local` a variable which is used as "local" storage for the walk,
    it is updated as the value from `$fn` before being passed to the
    children,
 1. `$dir` the direction of the walk whether it be "left" or "right"

`$self`, `$global`, `$local` and `$dir` are all passed to the callback
function....

The code itself is quite simple to look at...

```perl
sub walk {
  my( $self, $fn, $global, $local, $dir ) = @_;
  my ($v,$l,$r) = @{$self};
  $local = $fn->( $self, $global, $local, $dir||'' );
  $self->left->walk(  $fn, $global, $local, 'left'  ) if defined $self->has_left;
  $self->right->walk( $fn, $global, $local, 'right' ) if defined $self->has_right;
  return;
}
```

## Cloning - with walk 

```perl
sub clone {
  my( $self, $clone_fn ) = @_;
  $clone_fn ||= sub { $_[0] };
  my $clone = {};
  $self->walk( sub { my( $node, $global, $local, $dir ) = @_;
    if(exists $global->{'tree'} ) {
      my $child = BinaryTree->new( $clone_fn->( $node->value ) );
      $dir eq 'left' ? $local->add_child_left( $child ) : $local->add_child_right( $child );
      return $child;
    }
    $global->{'tree'} = BinaryTree->new( $clone_fn->( $node->value ) );
    return $global->{'tree'};
  }, $clone );
  return $clone->{'tree'};
}
```
We can use this `walk` method to clone our tree.
Global is a hashref with one entry - 'tree' which will contain our
cloned tree.

The first time through the loop it initialises the tree and adds the
root node to the tree and returns itself. `$local` is then this node.

For subsequent calls the tree exists and so a new BinaryTree objects is
produced and attached to it's parent (which is held in `$local`) either
as a left or right child.

`clone` can take an additional `callback` which is applied to each
node when being copied - which defaults to just a straight copy.

There are two more "walk methods" in the object, which dump the data:
either as a single line of values (flatten) or as "ASCII-art" to show
the nodes and their relationships.

```perl
sub flatten {
  my( $self,$dump_fn ) = @_;
  $dump_fn ||= sub { $_[0] };
  my $arrayref = [];
  $self->walk( sub {
    my($node,$global) = @_;
    push @{$global}, $dump_fn->( $node->value );
  }, $arrayref );
  return @{$arrayref};
}

sub dump {
  my( $self, $dump_fn ) = @_;
  $dump_fn ||= sub { $_[0] };
  $self->walk( sub {
    my( $node, $global, $local, $dir ) = @_;
    say join '',
        $local||'',
        $dir eq 'left' ? '<' : $dir eq 'right' ? '>' : ' ',
        ' ', $dump_fn->($node->value);
    return $local .= '  ';
  }, {}, '', '' );
  return;
}
```

Like clone they take a simple call back if you want to include a
function of the object's values rather than the value itself....
*a callback* within *a callback*.... You could even say its
***Turtles all the way down***...

## The solution

### Walking the tree to get the sum

We create a "*global*` variable which contains the total, walk through
all nodes and add the node value to this total.... We can then
retrieve the value by inspecting `$glob`..

```perl
my $glob = { 'total' => 0 };
$y->walk( sub {
  my( $node, $global ) = @_;
  $global->{'total'} += $node->value;
}, $glob );
```

### Walking the tree to update the nodes...

We pass the variable $glob back in, and use the total there
to update the value. For the value to be the sum of all the
other nodes, we can get this by adding all the nodes together
than subtracting away the node value....

So the 2nd half becomes.
```perl
$y->walk( sub {
  my( $node, $global ) = @_;
  $node->update( $global->{'total'} - $node->value );
}, $glob );
```
