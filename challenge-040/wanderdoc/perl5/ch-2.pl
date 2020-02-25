#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of numbers and set of indices belong to the list. Write a script to sort the values belongs to the indices.

For example,
List: [ 10, 4, 1, 8, 12, 3 ]
Indices: 0,2,5

We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.

Final List would look like below:
List: [ 1, 4, 3, 8, 12, 10 ]

=cut


my @array = (10, 4, 1, 8, 12, 3);
my @idx2sort = (0, 2, 5);

my %val2sort;

@val2sort{@idx2sort} = @array[@idx2sort];

my @idx_stack = sort {$a <=> $b } values %val2sort;

my @new_array;
for my $i ( 0 .. $#array )
{
     $new_array[$i] = exists $val2sort{$i} ?
          shift @idx_stack : $array[$i];

}

print join(', ', @new_array), $/;



print "Now saving indices not values:", $/;

@new_array = ();

my @idx_sorted = 
     sort {$val2sort{$a} <=> $val2sort{$b}} keys %val2sort;



for my $i ( 0 .. $#array )
{
     $new_array[$i] = exists $val2sort{$i} ?
          $array[shift @idx_sorted] : $array[$i];
}

print join(', ', @new_array), $/;