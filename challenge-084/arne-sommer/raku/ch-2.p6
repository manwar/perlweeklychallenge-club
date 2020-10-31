#! /usr/bin/env raku

unit sub MAIN ($matrix where $matrix.IO.f && $matrix.IO.r = 'example1.txt',
               :h(:$html),
	       :vv(:$very-verbose),
	       :v(:$verbose) = $very-verbose);

my $blue  = "\e[44m";
my $green = "\e[42m";
my $red   = "\e[101m";
my $stop  = "\e[0m";

if $html
{
  $blue  = '<span class="text-light bg-primary">';
  $green = '<span class="text-light bg-success">';
  $red   = '<span class="text-light bg-danger">';
  $stop  = '</span>';
}

my @matrix = $matrix.IO.lines.map( *.lc.words.list );

die "Uneven grid row length" unless [==] @(@matrix)>>.elems;
die "0 and 1 only" unless all( @matrix>>.List.flat ) eq any( 0, 1 );

my $rows    = @matrix.elems;
my $cols    = @matrix[0].elems;
my $matches = 0;

for 0 .. $rows -2 -> $row
{
  for 0 .. $cols -2 -> $col
  {
     for 1 .. $rows-1 -> $offset
     {
       last unless defined @matrix[$row+$offset][$col+$offset];
       check-box($row, $col, $offset);
     } 
  }
}

say $matches;

sub check-box ($row, $col, $offset)
{
  say ": Upper Left: [$row, $col] -> Lower Right: [{ $row+$offset }, { $col+ $offset}]" if $verbose;

  if @matrix[$row][$col]         == @matrix[$row+$offset][$col] ==
     @matrix[$row][$col+$offset] == @matrix[$row+$offset][$col+$offset] == 1
  {
    $matches++;
    say ": - is a match" if $verbose;
    highlight-matrix($row, $col, $offset, True) if $very-verbose;
  }
  else
  {
    highlight-matrix($row, $col, $offset, False) if $very-verbose;
  }
}

sub highlight-matrix ($row, $col, $offset, $hot)
{
  my $inside  = False;
  my $row-end = $row + $offset;
  my $col-end = $col + $offset;

  my $start = $hot ?? $green !! $red;

  for ^$rows -> $r
  {
    print ": [";
    for ^$cols -> $c
    {
      $inside = $row <= $r <= $row-end && $col <= $c <= $col-end;

      print " ";
      
      $inside
        ?? print $start ~ @matrix[$r][$c] ~ $stop
	!! print @matrix[$c][$r];
    }
    $inside = False;
    say " ]";
  }
  say "";
}