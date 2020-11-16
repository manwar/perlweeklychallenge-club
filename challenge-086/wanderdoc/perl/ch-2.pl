#!/perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given Sudoku puzzle (9x9).
Write a script to complete the puzzle and must respect the following rules:
a) Each row must have the numbers 1-9 occuring just once.
b) Each column must have the numbers 1-9 occuring just once.
c) The numbers 1-9 must occur just once in each of the 9 sub-boxes (3x3) of the grid.
=cut







use List::Util qw(first);

my @DIGITS = (1 .. 9);
my $table;
for my $line ( <DATA> )
{
     chomp($line);

     $line =~ tr/_/0/;
     push @$table, [split(/\s/,$line,9)];
}

print_table($table);

my @SOLS;
solve($table);
for my $t ( @SOLS) 
{ 
     print_table($t); 
}


sub solve
{
     my ($solution) = @_;

     my $nulls = first{ my $r = "@$_"; $r =~ tr/0/0/; } @$solution;
     if ( !$nulls )
     {
          my $s = deep_copy($solution);

          push @SOLS, $s;
     }
     for my $row ( 0 .. $#$solution )
     {
          for my $col ( 0 .. $#{$solution->[$row]} )
          {
               next unless $solution->[$row][$col] == 0;


               for my $n ( @DIGITS )
               {
                    if ( allowed( $solution, $row, $col, $n ) )
                    {
                         $solution->[$row][$col] = $n;
                         if ( solve( $solution ) != 0 )
                         {
                              return $solution;

                         }
                         $solution->[$row][$col] = 0;
                    }
               }
               return 0;
          }
     }
}

sub allowed
{
     my ( $sol, $r, $c, $n ) = @_;
     my $matrix_row = int($r / 3) * 3;
     my $matrix_col = int($c / 3) * 3;

     return not ( 
          first { $_ == $n } @{$sol->[$r]} 

          or 
          first { $_ == $n } map { $sol->[$_ - 1][$c] } @DIGITS
          or
          first { $_ == $n }
               map { @{$_}[$matrix_col .. $matrix_col + 2] }
               @{$sol}[$matrix_row .. $matrix_row + 2]
     );
}

sub print_table
{
     my ($aoa) = @_;
     for my $row ( 0 .. @$aoa )
     {
          for my $col ( 0 .. $#{$aoa->[$row]} )
          {
               print "$aoa->[$row][$col] ";


               print "| " 
                    if ( not ( ($col + 1) % 3 ) and ( ($col + 1) % 9 ));
          }
          print $/;
          print '-' x 21, $/ 
               if ( not ( ($row + 1) % 3 ) and ( ($row + 1) % 9 ));
     }
     print $/;

}

sub deep_copy
{
     my $aref = shift;
     my @arr;
     push @arr, [@$_]  for @$aref;
     return [@arr];
}


__DATA__
_ _ _ 2 6 _ 7 _ 1
6 8 _ _ 7 _ _ 9 _
1 9 _ _ _ 4 5 _ _
8 2 _ 1 _ _ _ 4 _
_ _ 4 6 _ 2 9 _ _
_ 5 _ _ _ 3 _ 2 8
_ _ 9 3 _ _ _ 7 4
_ 4 _ _ 5 _ _ 3 6
7 _ 3 _ 1 8 _ _ _
