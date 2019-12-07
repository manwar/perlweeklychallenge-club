#!/usr/bin/env perl6

use JSON::Fast;

my %data = 'sun-data.json'.IO.slurp.&from-json.map(|*);
my Duration ( $nov, $dec );

for %data.keys -> $k {
  my $d := Date.new($k);
  my &adder := -> $month is rw {
    $month += [-] %data{$k}<sunset sunrise>.map({ DateTime.new($_) })
  };

  given $d.month {
    when 11 {
      $nov.&adder;
    }
    when 12 {
      $dec.&adder;
    }
  }
}

say "Daylight in November: $nov seconds";
say "Daylight in December: $dec seconds";
say "Difference: {($nov - $dec).abs} seconds";
