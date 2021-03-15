#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a binary tree. Write a script to represent the given binary tree as an object and flatten it to a linked list object. Finally print the linked list object.
Example: Input:
        1
       / \
      2   3
     / \
    4   5
       / \
      6   7
    Output:
        1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3
=cut
use Struct::Dumb; # for LL below.

package treeNode # Tree should be an object. OOP by Conway ch.4.2.
{
     use constant {VAL => 0, LEFT => 1, RIGHT => 2, PARENT => 3};
     my %_index_for; 
     @_index_for{qw(val left right parent)} = (VAL, LEFT, RIGHT, PARENT);
     my @_default_data;

     @_default_data[VAL, LEFT, RIGHT, PARENT] = (undef) x 4;
     sub new
     {
          my ($caller, %arg) = @_;
          my $self = bless [], $caller;
          for my $member ( keys %_index_for )
          {
               my $index = $_index_for{$member};
               if (exists $arg{$member})
               { 
                    $self->[$index] = $arg{$member} 
               }


               else
               { 
                    $self->[$index] = $_default_data[$index] 

               }
          }
          return $self;
     }

     sub add_left  { $_[0]->[LEFT]  = $_[1]; $_[1]->[PARENT] = $_[0] }
     sub add_right { $_[0]->[RIGHT] = $_[1]; $_[1]->[PARENT] = $_[0] }
     sub left { return $_[0]->[LEFT] }
     sub right { return $_[0]->[RIGHT] }
     sub val { return $_[0]->[VAL] }

     my @_string;


     sub traverse
     {
          my $node = $_[0];

          if (defined $node and defined $node->val)
          {
               push @_string, $node->val;
          }

          traverse($node->left) if $node->left;
          traverse($node->right) if $node->right;
     }

     sub flattened 
     {  
          my $node = $_[0];
          @_string = ();

          $node->traverse;
          return @_string;
     }
     
     sub print_tree # https://stackoverflow.com/questions/13484943 # valiano
     {
          my $node = $_[0];
          return unless $node->val;

          print $node->val, $/;
          print_twigs($node, "");
          print $/;
     }
     sub print_twigs
     {
          my ($node, $prefix) = @_;
          return unless $node->val;
          return unless ($node->left or $node->right);

          $prefix //= '';
          print $prefix;
          print (($node->right ) ? '|--' : '');
          if ( $node->right )
          {
               my $prefix_r = $prefix . 
                    (($node->left and $node->right->right and $node->right->left)? 
                    '|  ' : '   ');

               print $node->right->val, $/;
               print_twigs($node->right, $prefix_r);
          }
          if ($node->left)
          {
               print (($node->right) ? $prefix : '');
               print '\--';

               print $node->left->val, $/;
               print_twigs($node->left, $prefix . '   ');
          }
     }
     1;
}

my $root = treeNode->new(val => 1);
my $n2 = treeNode->new(val => 2);
$root->add_left($n2);
$root->add_right(treeNode->new(val => 3));
$n2->add_left(treeNode->new(val => 4));

my $n5 = treeNode->new(val => 5);
$n2->add_right($n5);
$n5->add_left(treeNode->new(val => 6));
$n5->add_right(treeNode->new(val => 7));


my @arr = $root->flattened;

$root->print_tree;

# Creating LL. Code from challenge-071.
my ($head, $counter) = create_list([@arr]);
print_list($head);

sub create_list
{
     my $start = undef;
     struct Node => [qw( val next )] , named_constructor => 1;
     my $end = \$start;
     my $input = $_[0];
     my $count = 0;


     for my $val ( @$input )
     {
          my $node = Node( val => $val , next => undef );
          $$end = $node;
          $end = \$node->next;
          $count++;
     } 
     return ($start, $count);

}

sub print_list
{
     my $node = $_[0];

     while ( $node->next )
     {

          print $node->val, '->';
          $node = $node->next;
     }
     print $node->val, $/;
}