#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given coordinates, a string that represents the coordinates of a square of the chessboard as shown below:
Write a script to return true if the square is white, and false if the square is black.

Example 1

Input: $coordinates = "d3"
Output: true

Example 2

Input: $coordinates = "g5"
Output: false

Example 3

Input: $coordinates = "e6"
Output: true
=cut

package Field
{
     use constant {true => 1, false => 0};
     use subs 'to_num', 'from_num', 'field_color';
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
     sub field_color
     {
          my $self = $_[0];
          if ( $self->chess =~ /[aceg][1357]/ or $self->chess =~ /[bdfh][2468]/)
          {
               return false;
          }
          else
          {
               return true;
          }
     }
1;
};

use constant {true => 1, false => 0};
use Test2::V0;
is(testing_field('d3'), true, 'Example 1');
is(testing_field('g5'), false, 'Example 2');
is(testing_field('e6'), true, 'Example 3');
done_testing();

sub testing_field
{
     my $field = Field->new(chess => $_[0]);
     return $field->field_color;
}