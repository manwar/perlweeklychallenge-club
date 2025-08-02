#! /usr/bin/env perl6

unit sub MAIN ($str,
               *@widths where all(@widths) ~~ UInt && @widths.elems == 26,
               :v(:$verbose));

my %width;

for 'a' .. 'z' -> $letter
{
  %width{$letter} = @widths.shift.Int;
}

say ": Widths: { %width.raku }" if $verbose;

my $line  = "";
my $width = 0;
my $id    = 0;

for $str.comb -> $letter
{
  if $width + %width{$letter} > 100
  {
    $id++;
    say ": Line $id: $line ($width pixels)" if $verbose;
    $line  = "";
    $width = 0;
  }

  $line  ~= $letter;
  $width += %width{$letter};
}

if $line
{
  $id++;
  say ": Line $id: $line ($width pixels)" if $verbose;
}

say "($id, $width)";
