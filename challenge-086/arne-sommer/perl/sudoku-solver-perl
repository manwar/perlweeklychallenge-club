#! /usr/bin/env perl

use strict;
use feature 'say';
use feature 'signatures';
use Getopt::Long;
use List::MoreUtils qw(uniq singleton);

no warnings qw(experimental::signatures);

my $verbose = 0;
my $very_verbose = 0;

GetOptions("verbose"  => \$verbose,
           "vv"       => \$very_verbose);

$verbose = 1 if $very_verbose;
    
my $filename = shift(@ARGV) || die "Please specify a sudoku file";

my @sudoku;

my $rows = 0;

open my $in, $filename or die "$filename: $!";

while (my $line = <$in>)
{
  my @values = split(/\s+/, $line);

  shift @values if $values[0]         eq "[";
  pop   @values if $values[@values-1] eq "]";

  my $cols = @values;
  die "Wrong number of columns: $cols. Should have been 9" unless $cols == 9;
  
  $sudoku[$rows++] = \@values;
}

close $in;

die "Wrong number of lines $rows" unless $rows == 9;


my $unknown = count_unknowns();

say ": Unknown values: $unknown" if $verbose;

sub count_unknowns
{
  my $unknown = 0;
  for my $row (0 .. 8)
  {
    for my $col (0 .. 8)
    {
      $unknown++ if $sudoku[$row][$col] eq "_";
    }
  }
  return $unknown;
}


sub get_row ($row, $col)
{
  return map { $sudoku[$row][$_] } (0..8);
}

sub get_col ($row, $col)
{
  return map { $sudoku[$_][$col] } (0..8);
}

sub get_box ($row, $col)
{
  my $row_actual = int($row / 3) * 3;
  my $col_actual = int($col / 3) * 3;
  
  return $sudoku[$row_actual  ][$col_actual  ],
         $sudoku[$row_actual  ][$col_actual+1],
         $sudoku[$row_actual  ][$col_actual+2],
         $sudoku[$row_actual+1][$col_actual  ],
         $sudoku[$row_actual+1][$col_actual+1],
         $sudoku[$row_actual+1][$col_actual+2],
         $sudoku[$row_actual+2][$col_actual  ],
         $sudoku[$row_actual+2][$col_actual+1],
         $sudoku[$row_actual+2][$col_actual+2];
}

my $pass = 1;
my $unknown_prev = 999;

if ($very_verbose) { say ":: ", join(" ", @$_) for @sudoku; }

LOOP: while (1)
{
  if ($unknown_prev == $unknown)
  {
    say "Unsolvable Sudoku (by this program)";
    exit;
  }

  $unknown_prev = $unknown;
  
  say ": Pass: $pass with $unknown unknowns" if $verbose;
  $pass++;
  
  for my $row (0 .. 8)
  {
    for my $col (0 .. 8)
    {
      last LOOP if $unknown == 0;
      next unless $sudoku[$row][$col] eq "_";

      my @row = sort grep { /^[1-9]$/ } get_row($row, $col);
      my @col = sort grep { /^[1-9]$/ } get_col($row, $col);
      my @box = sort grep { /^[1-9]$/ } get_box($row, $col);
      
      if ($very_verbose)
      {
        say ":: [$row,$col] Row: ", join(", ", sort @row); 
        say ":: [$row,$col] Col: ", join(", ", sort @col);
        say ":: [$row,$col] Box: ", join(", ", sort @box);
      }
      
      my @all     = uniq sort ( @row, @col, @box );   
      my @missing = singleton (@all, 1..9);

      say ":: all: ", join(" ", @all) if $very_verbose;
      say ": Pos[$row, $col] - missing: ", join(" ", @missing) if $verbose;

      if (@missing.elems == 1)
      {
        $unknown--;
	say ":: [$row,$col] => @missing[0] (replacing unknown $unknown)" if $very_verbose;
        $sudoku[$row][$col] = $missing[0];
        if ($very_verbose) { say ":: ", join(" ", @$_) for @sudoku; }
      }
    }
  }
}

say "[", join(" ", @$_), "]" for @sudoku;
