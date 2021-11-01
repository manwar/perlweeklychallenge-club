#!/usr/bin/env raku

my $dt = Date.new(1900, 12, 31);

my $longs := gather while $dt.year <= 2100
{
    take $dt.year if $dt.week-number == 53;
    $dt .= later(:1years);
}

say $longs.join(', ')
          .comb(6)
          .rotor(5, :partial)
          .join("\n");
