#!/usr/bin/env raku
use v6;

subset PosInt of Int where * > 0;
sub distinct-terms-count (PosInt:D $m, PosInt:D $n) {
   my $width          = ($n * $m).chars;
   my $idx_width      = $m.chars;
   my &data_formatter = sub (*@items) {
      my $first = @items.shift;
      join ' ', sprintf("%{$idx_width}d", $first),
        @items.map: { sprintf "%{$width}d", $_ };
   };
   my @lines;
   @lines.push:
     sprintf("%{$idx_width}s | ", 'x') ~ &data_formatter(1 .. $n);
   @lines.push:
     ('-' x $idx_width) ~ '-+-'
     ~ ('-' x (@lines[0].chars- 3 - $idx_width));
   my %distinct;
   for 1 .. $m -> $r {
      @lines.push: sprintf("%{$idx_width}d | ", $r) ~ &data_formatter(
         (1 .. $n).map: {
            %distinct{my $p = $r * $_} = 1;
            $p;
         }
      );
   } ## end for my $r (1 .. $m)
   return join("\n", @lines), %distinct.keys.sort({ $^a <=> $^b });
}

sub MAIN ($m = 3, $n = 5) {
   my ($table, $distinct) = distinct-terms-count($m, $n);
   my @distinct = @$distinct;
   put '';
   put S:g/^^/      / with $table;
   put '';
   put 'Distinct Terms: ', @distinct.join(', ');
   put 'Count: ', @distinct.elems;
}
