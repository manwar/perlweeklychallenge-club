#! /usr/bin/env raku

unit sub MAIN (Str $matrix = "4 3 2 1 | 5 4 3 2 | 6 5 4 3", :v(:$verbose)); 

my @matrix = $matrix.split("|")>>.words>>.Array;
my @size   = @matrix>>.elems;

die "Must have at least 2 rows" unless @size.elems >= 2;
die "The rows must have the same size" unless [==] @size;

while @matrix.elems
{
  @matrix.shift if @matrix[0].elems == 0;

  last unless @matrix.elems;

  my $row = 0;
  my $col = @matrix[$row].end;

  my $value = @matrix[$row].pop;

  say ": Row:0 { @matrix.raku } -> $value (last value removed from row)" if $verbose;

  loop
  {
    $row++;
    $col++;
    last unless defined @matrix[$row];
    last unless defined @matrix[$row][$col];

    my $new = @matrix[$row].pop;
    
    say ": Row:$row { @matrix.raku } -> $new (last value removed from row)" if $verbose;
    
    unless $value eq $new
    {
      say 'false';
      exit;
    }
  }
}

say 'true';
