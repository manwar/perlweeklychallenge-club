#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say for hot_day(temperature_txt());

sub hot_day ($input) {
   my $p; # previous value
   map { $_->[0] } # keep the date only

      # filter according to the input requirement
      grep { ((my $test, $p) = (($p // $_->[1]) < $_->[1], $_->[1]))[0] }
      sort { $a->[0] cmp $b->[0] } # sort by date
      map { [ split m{,\s*}mxs ] } # split on date, temperature
      split m{\n}mxs, $input;      # split into lines
}

sub temperature_txt {
   return <<'END' =~ s{^\s+}{}rgmxs;
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
