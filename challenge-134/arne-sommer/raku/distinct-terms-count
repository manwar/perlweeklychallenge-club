#! /usr/bin/env raku

unit sub MAIN (Int $m where $m > 0, Int $n where $n > 0, :v($verbose));

my @values;

for 1 .. $m -> $row
{
  @values.push: (1 .. $n).map({ $_ * $row });
}

# say ":", @values.raku;

my $width   = ($m * $n).chars;
my $r-width = ($m).chars;

say ":Max width number: $width"   if $verbose;
say ":Max width row ID: $r-width" if $verbose;

say "x".fmt("%{$width-1}s"), " |", (1..$n).map({ $_.fmt("%{$width}d") }).join(" ");

say "-" x $r-width, "-+", "-" x ($n * ($width +1) -1);

for @values -> @row
{
  state $i = 0;

  say "{ (++$i).fmt("%{$r-width}d") } |", @row.map({ ($_).fmt("%{$width}d") }).join(" ");
}

my @distinct = @values>>.List.flat.sort.squish;

say "";
say "Distinct Terms: { @distinct.join(", ") }";
say "Count: { @distinct.elems }";
