#! /usr/bin/perl6

my $a=0;
my $b=FatRat.new(1,1);
my $e=Rat.new(1);

while (1) {
  $a++;
  $b/=$a;
  $e+=$b;
  print "$e\n";
}
