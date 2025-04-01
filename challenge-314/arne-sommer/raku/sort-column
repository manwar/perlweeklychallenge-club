#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 1 && ( [==] @list>>.chars ),
               :v(:$verbose));

my $cols = @list[0].chars;

my @cols;

for @list -> $string
{
  for ^$cols -> $index
  {
    @cols[$index] ~= $string.substr($index, 1);
  }
}

say ": Columns: { @cols.raku }" if $verbose;

my $deleted = 0;

for @cols -> $column
{
  my $sorted = $column.comb.sort.join;

  print ": Column: " if $verbose;

  if $column ne $sorted
  {
    $deleted++;
    say " => non sorted" if $verbose;
  }
  elsif $verbose
  {
    say " => sorted";
  }
}

say $deleted;
