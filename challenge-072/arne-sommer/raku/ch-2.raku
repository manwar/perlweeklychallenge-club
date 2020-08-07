#! /usr/bin/env raku

subset PosInt of Int where * >= 1;

unit sub MAIN (Str $filename, PosInt $A, PosInt $B where $B >= $A, :v(:$verbose));

die "No such file $filename" unless $filename.IO.e;
die "Not a file $filename" unless $filename.IO.f;
die "Cannot read from $filename" unless $filename.IO.r;

my $count = 0;

for $filename.IO.lines -> $line
{
  $count++;

  say ": Considering line $count: $line" if $verbose;

  next if $count < $A;

  say $line;
  
  last if $count == $B;
}
