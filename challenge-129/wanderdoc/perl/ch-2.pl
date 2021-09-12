#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two linked list having single digit positive numbers.
Write a script to add the two linked list and create a new linked representing the sum of the two linked list numbers. The two linked lists may or may not have the same number of elements.
Example 1:

Input: L1 = 1 -> 2 -> 3
       L2 = 3 -> 2 -> 1
Output: 4 -> 4 -> 4

Example 2:

Input: L1 = 1 -> 2 -> 3 -> 4 -> 5
       L2 =           6 -> 5 -> 5
Output:     1 -> 3 -> 0 -> 0 -> 0
=cut

use Data::Dumper;
use constant {VAL => 0, NEXT => 1, PREV => 2};
use Storable qw(dclone);




my $first  =  create_list([1 .. 5]);
my $second =  create_list([6, 5, 5]);
my $nl = add_lists($first, $second); 

print_list($nl); 
print_backwards_2($nl);
print_structure($nl);

print $/ x 2;




$first = create_list([9, 9, 9, 9, 9, 9]);
$second = create_list([8, 8, 8]);
$nl = add_lists($first, $second); 
print_list($nl); 
print_backwards_2($nl);
print_structure($nl);
print $/ x 2; 



$first = create_list([1, 2, 3]);
$second = create_list([3, 2, 1]);
$nl = add_lists($first, $second);
print_list($nl); 
print_backwards_2($nl);
print_structure($nl);
print $/ x 2; 


sub create_list
{
     my $start = undef;
     my $end = \$start;
     my $input = $_[0];
     
     my $prev = [undef, undef, undef];

     for my $val ( @$input )
     {
          my $node;
          $node->[VAL] = $val;
          $node->[NEXT] = undef;
          $node->[PREV] = $prev;
          $prev = $node;
          $$end = $node;

          $end = \$node->[NEXT];
     } 
     return $start;
}

sub print_list
{
     my $node = $_[0];

     while (defined $node)
     {
          print $node->[VAL]; 
          print $node->[NEXT] ? '->' : '';
          $node = $node->[NEXT];
     }
     print $/;
}

sub print_structure
{
     my $node = $_[0];
     while ( $node->[NEXT] )
     {
          my $pv = defined $node->[PREV] && defined $node->[PREV]->[VAL] ? 
               $node->[PREV]->[VAL]: 'H';
          print join(" ", $pv, $node->[VAL], $node->[NEXT]->[VAL]), $/;


          $node = $node->[NEXT];
     }
     print join(" ", $node->[PREV]->[VAL], $node->[VAL], 'T'), $/;
}

sub print_backwards_2
{
     my $node = $_[0];

     $node = $node->[NEXT] while $node->[NEXT];
     while (defined $node)
     {
          print $node->[VAL] if defined($node->[VAL]);
          print defined $node->[PREV] && defined $node->[PREV]->[VAL] ? '<-' : ''; 
          $node = $node->[PREV];
     }

     print $/;
}

sub add_lists
{
     my ($first, $second) = @_;
     my $count_first = 0; 
          do { $count_first++ and $first = $first->[NEXT] } while $first->[NEXT];

     my $count_second = 0; 
          do {$count_second++ and $second = $second->[NEXT]} while $second->[NEXT];

     my $new_list = $count_first > $count_second ? dclone($first) : dclone($second);
     my $carry = 0;

     while (defined $new_list->[PREV]->[VAL])
     {

          my $one = $first->[VAL];
          my $two = $second->[VAL];
          $new_list->[VAL] = $one + $two + $carry;
          $carry = 0;
          if ( $new_list->[VAL] > 9 )
          {
               $carry = int($new_list->[VAL] / 10);
               $new_list->[VAL] = $new_list->[VAL] % 10;

          }
          $first = defined $first->[PREV]->[VAL] ? $first->[PREV] : [0]; ;
          $second = defined $second->[PREV]->[VAL] ? $second->[PREV] : [0] ;
          $new_list = $new_list->[PREV];

     }
     
     $new_list->[VAL] = $first->[VAL] + $second->[VAL]; # last(first).

     if ( $carry > 0 )
     {
          $new_list->[VAL] += $carry;


          if ( $new_list->[VAL] > 9 )
          {
               $carry = int($new_list->[VAL] / 10);

               $new_list->[VAL] = $new_list->[VAL] % 10;
               $new_list->[PREV] = [$carry, $new_list, undef];
               $new_list = $new_list->[PREV];
          }
     }
     return $new_list;
}