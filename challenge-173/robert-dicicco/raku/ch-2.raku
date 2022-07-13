use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-13
# Challenge 173 Sylvbester's Sequence ( Rsku )

my @arr = [2];
my $count = 1;

say @arr[0];

loop {

  my $sum = ([*] @arr ) + 1;

  @arr.push($sum);

  say $sum;

  $count++;

  last if $count == 10;

}
