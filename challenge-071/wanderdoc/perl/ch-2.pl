#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a singly linked list and a positive integer $N (>0). Write a script to remove the $Nth node from the end of the linked list and print the linked list. If $N is greater than the size of the linked list then remove the first node of the list.
NOTE: Please use pure linked list implementation.

Example
Given Linked List: 1 -> 2 -> 3 -> 4 -> 5
when $N = 1: Output: 1 -> 2 -> 3 -> 4
when $N = 2: Output: 1 -> 2 -> 3 -> 5

when $N = 3: Output: 1 -> 2 -> 4 -> 5
when $N = 4: Output: 1 -> 3 -> 4 -> 5

when $N = 5: Output: 2 -> 3 -> 4 -> 5
when $N = 6: Output: 2 -> 3 -> 4 -> 5
=cut

use Struct::Dumb;
my $node_to_remove = shift // die "Give position (from the ende) of the node to remove!$/"; 
my @input = 1 .. 5; 

my ($head, $counter) = create_list([@input]);

print_list($head);
remove_from_end($head, $node_to_remove);
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

sub remove_from_end
{
     my $node = $_[0];
     my $node_num = $_[1];
     
     my @noderefs;

     while ( $node )
     {
          unshift @noderefs, $node;
          $node = $node->next;
     }

     if ( $node_num >= scalar @noderefs )
     {

          _splice_node($noderefs[$#noderefs], 1);
     }
     elsif ( $node_num > 0 )
     {
          _splice_node($noderefs[$node_num]);
     }
     else
     {

          print "Position cannot be processed!$/";
     }
}






sub _splice_node
{
     my $node       = $_[0];
     my $first_node = $_[1] || 0;
     my $node_to_splice = $node->next;
     $node->val = $node_to_splice->val if $first_node;
     $node->next = $node_to_splice->next;
     $node_to_splice = undef;

}


sub print_list
{
     my $node = $_[0];

     while ( $node->next )
     {

          print $node->val, '->';
          $node = $node->next;
     }
     print $node->val, $/; # last node.
}





=output

perl ... \071\ch-2.pl 0
1->2->3->4->5
Position cannot be processed!
1->2->3->4->5

perl ... \071\ch-2.pl 1
1->2->3->4->5
1->2->3->4

perl ... \071\ch-2.pl 2
1->2->3->4->5
1->2->3->5

perl ... \071\ch-2.pl 3
1->2->3->4->5
1->2->4->5

perl ... \071\ch-2.pl 4
1->2->3->4->5
1->3->4->5

perl ... \071\ch-2.pl 5
1->2->3->4->5
2->3->4->5

perl ... \071\ch-2.pl 6
1->2->3->4->5
2->3->4->5

=cut