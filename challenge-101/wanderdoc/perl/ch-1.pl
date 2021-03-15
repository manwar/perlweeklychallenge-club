#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array @A of items (integers say, but they can be anything). Your task is to pack that array into an MxN matrix spirally counterclockwise, as tightly as possible. ‘Tightly’ means the absolute value |M-N| of the difference has to be as small as possible.
Example 1: Input: @A = (1,2,3,4)

Output:

    4 3
    1 2

Example 2: Input: @A = (1..6)

Output:
    6 5 4
    1 2 3
or
    5 4
    6 3
    1 2


Example 3: Input: @A = (1..12)

Output:
       9  8  7 6
      10 11 12 5
       1  2  3 4
or
       8  7 6
       9 12 5
      10 11 4
       1  2 3
=cut




my @COUNTER_CLOCK = ('e', 'n', 'w', 's');
my %DIRECTIONS = ('n' => [-1,  0], 's' => [ 1,  0], 
                  'e' => [ 0,  1], 'w' => [ 0, -1],);






sub create_matrix
{
     my ($row, $col, $val) = @_;
     my $mtr;
     do { my $i = $_;
          do { $mtr->[$i][$_] = $val } for 0 .. $col - 1 }
          for 0 .. $row - 1;
     return $mtr;

}

sub is_possible
{
     my ($max_row_idx, $max_col_idx, 
          $this_row_idx, $this_col_idx, $dir) = @_;
     if ( ($this_row_idx + $DIRECTIONS{$dir}->[0] <= $max_row_idx) and
          ($this_row_idx + $DIRECTIONS{$dir}->[0] >= 0 )           and

          ($this_col_idx + $DIRECTIONS{$dir}->[1] <= $max_col_idx) and
          ($this_col_idx + $DIRECTIONS{$dir}->[1] >= 0 ) )
     {
          return 1;
     }
     else
     {
          return 0;

     }
}

sub neighbour_is_occupied
{
     my ($mtr, $this_row_idx, $this_col_idx, $dir) = @_;
     if ( $mtr->[$this_row_idx + $DIRECTIONS{$dir}->[0]]
                [$this_col_idx + $DIRECTIONS{$dir}->[1]] )

     {
          return 1;
     }
     else
     {
          return 0;
     }
}

sub print_matrix
{
     my $aref = $_[0];
     for my $i ( 0 .. $#$aref )
     {

          my $fmt = "%3s" x scalar @{$aref->[$i]};
          $_ //= '' for @{$aref->[$i]};
          print sprintf($fmt, @{$aref->[$i]}), $/;

     }
     print $/, $/;
}

sub tight_size_3
{
     my $num = $_[0];
     my $first = int(sqrt($num));

     if ( $first * $first == $num ) { return ($first, $first); }
     else
     {
          my $second = int(sqrt($num) + 0.5);
          if ( $first * $second > $num ) { return ($first, $second); }
          else
          {

               $second++ while $first * $second < $num;
               return ($first, $second);
          }
     }
}





for my $ar ( [1 .. 4], [1 .. 6], [1 .. 12], [1 .. 19], [1 .. 89], ['a' .. 'z'] )
{
     my @array = @$ar;
     my ($row, $col) = tight_size_3(scalar @array);
     my $mtr = create_matrix($row, $col, undef);

     my ($this_row, $this_col) = ($row - 1, 0);

     $mtr->[$this_row][$this_col] = $array[0];

     for my $i ( 1 .. $#array )
     {
          if ( is_possible($row - 1, $col - 1, $this_row, $this_col, $COUNTER_CLOCK[0]) and 
            not neighbour_is_occupied($mtr, $this_row, $this_col, $COUNTER_CLOCK[0])
            )
          {

               my $dir = $COUNTER_CLOCK[0];

               $this_row += $DIRECTIONS{$dir}->[0];
               $this_col += $DIRECTIONS{$dir}->[1];
               $mtr->[$this_row][$this_col] = $array[$i];
          }
          else
          {

               push @COUNTER_CLOCK, shift @COUNTER_CLOCK; 
               redo;
          }
     }
     print join(" ", @array), $/, $/;
     print_matrix($mtr);
}