#!/usr/bin/env perl

say for mask_code(qw< ab-cde-123 123.abc.420 3abc-0010.xy
   1234567.a a-1234-bc a.b.c.d.e.f >);

sub mask_code {
   state $is_target = { map { $_ => 1 } ('0' .. '9', 'a' .. 'z') };
   map {
      my $copy = $_;
      my ($i, $I, $n) = (0, length($copy), 0);
      while ($n < 4 && $i < $I) {
         if ($is_target->{substr $copy, $i, 1}) {
            substr $copy, $i, 1, 'x';
            ++$n;
         }
         ++$i;
      }
      $copy;
   } @_;
}
