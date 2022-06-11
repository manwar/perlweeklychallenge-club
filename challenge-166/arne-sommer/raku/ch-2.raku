#! /usr/bin/env raku

unit sub MAIN (*@dirs where @dirs.elems >= 3 && all(@dirs) ~~ .IO.d && all(@dirs) ~~ .IO.r);

my $dir-count = @dirs.elems;

my %dir;

for @dirs -> $dir
{
  %dir{$dir} = $dir.IO.dir.map({ .d ?? .basename ~ '/' !! .basename }).Set;
}

my %all = %dir.values>>.List.flat.Bag;

my $max-length = (%all.keys>>.chars.max, @dirs>>.chars.max).max;

my @head;

for @dirs -> $dir
{
  @head.push: $dir.fmt("%-{$max-length}s");
}

say @head.join(" | ");

say "-" x (3 + $max-length) * $dir-count;

for sort keys %all -> $file
{
  next if %all{$file} == $dir-count;

  my @row;

  for @dirs -> $dir
  {
    @row.push: "{ (%dir{$dir}{$file} ?? $file !! '').fmt("%-{$max-length}s") }";
  }

  say @row.join(" | ");
}
