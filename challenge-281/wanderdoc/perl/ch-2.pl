#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
A knight in chess can move from its current position to any square two rows or columns plus one column or row away. So in the diagram below, if it starts a S, it can move to any of the squares marked E.
Write a script which takes a starting position and an ending position and calculates the least number of moves required.

Example 1

Input: $start = 'g2', $end = 'a8'
Ouput: 4

g2 -> e3 -> d5 -> c7 -> a8

Example 2

Input: $start = 'g2', $end = 'h2'
Ouput: 3

g2 -> e3 -> f1 -> h2
=cut

package Field
{
     use subs 'to_num', 'from_num';
     use Class::Tiny qw (chess num);
     sub to_num
     {
          my $self = $_[0]; 
          my $notation = $self->chess;
          my %map; 
          @map{'a' .. 'h'} = 0 .. 7;
          my ($y, $x) = split(//, $notation); 
          return [$map{$y}, $x - 1];
     };
     sub from_num
     {
          my ($self, $field_ref) = @_;
          my %map; 
          @map{0 ..7} = 'a' .. 'h';
          my ($y, $x) = @$field_ref;
          return join('', $map{$y}, $x + 1);
     }
1;
};

package Knight
{
     use parent -norequire, 'Field'; 
     use subs 'make_move';
     use Class::Tiny  
     {
          chess => 'Field->chess',
          all_moves => sub
          {
               my @arr = ([-2, -1], [-1, -2], [-2, 1], [-1, 2], [2, -1], [1, -2], [2, 1], [1, 2]);
               return \@arr;
          }
     };
     sub make_move 
     {
          my $self = $_[0];
          my $coord_delta = $_[1]; 
          my $coord_old = $self->to_num;
          my $x_new = $coord_old->[1] + $coord_delta->[1]; 
          my $y_new = $coord_old->[0] + $coord_delta->[0]; 
          if ( $x_new >= 0 and $y_new >= 0 and $x_new < 8 and $y_new < 8 )
          {
               $self->num([$y_new, $x_new]);
               $self->chess($self->from_num($self->num));
          }
          return $self;
     }
1;
};

use Test2::V0;

is(test_path('g2', 'a8'), 4, 'Example 1');
is(test_path('g2', 'h2'), 3, 'Example 2');
done_testing();

sub test_path
{
     my ($start, $end) = @_;
     my @output = find_path($start, $end);
     return scalar @output - 1;
}


sub find_path
{
     my ($start, $end) = @_;
     my @queue;
     my %seen;

     @queue = ([$start]);
     
     $seen{$start} = 1;

     while ( @queue )
     {
          my $this = shift @queue; 
          my $place = $this->[-1]; 
          
          if ( $place eq $end )
          {
               return @$this;
          }
          else
          {
               MOVE: for my $move (@{Knight->all_moves})
               {
                    my $knight = Knight->new(chess => $place);
                    $knight->make_move($move); 
                    next MOVE if ($seen{$knight->chess});
                    $seen{$knight->chess} = 1;
                    push @queue, [@$this, $knight->chess];
               }
          }
     }
}

