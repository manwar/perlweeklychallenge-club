#!/usr/bin/env raku
use v6;
sub MAIN { .put for hot-day(temperature-txt()) }

sub hot-day ($input) {
   my $p;  # previous value
   $input.split(/\n/)  # split into lines
      .grep(/\,/)      # keep valid lines only
      .map({ [ .split(/\,\s*/) ] }) # split on [date, temperature]
      .sort({ $^a[0] cmp $^b[0] })  # sort by date

      # filter according to the input requirement
      .grep({ ((my $t, $p) = (($p // $_[1]) < $_[1], $_[1]))[0] })

      .map({ $_[0] } ); # keep the date only
}

sub temperature-txt {
   return q:to/END/;
      2022-08-01, 20
      2022-08-09, 10
      2022-08-03, 19
      2022-08-06, 24
      2022-08-05, 22
      2022-08-10, 28
      2022-08-07, 20
      2022-08-04, 18
      2022-08-08, 21
      2022-08-02, 25
      END
}
