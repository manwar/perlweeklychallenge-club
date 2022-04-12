use v6;

use Lingua::EN::Numbers;

# AUTHOR: Robert DiCicco
# DATE: 7-APR-2022
# Challenge 159 Farey Sequence ( Raku )

my %equivs;

sub MAIN(Int $num) {
  my $d = $num;

  while $d {
    for (1..($d-1)) {
      my $frac = pretty-rat($_/$d);
      %equivs{$frac} = $_/$d;
      #say $frac;
    }

    $d--;
  }

  print("Input: \$n = $num\n");
  print '0/1 ';

  for %equivs.sort(*.value) {
    my $k = $_.key;
    print("$k ");
  }

  print '1/1';
  say "\n";
}
