#! /usr/bin/perl6

my ($s,$c,$n)=(0,0,0);
for @*ARGS -> $angle {
  my $aa=$angle*pi/180;
  $s+=sin($aa);
  $c+=cos($aa);
  $n++;
}
my $oa=atan2($s/$n,$c/$n);
say $oa*180/pi;
