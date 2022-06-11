use strict;
use warnings;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 21-MAR-2022
# Challenge 157 Pythagorean Means ( Perl )

sub arithmetic {
  my $arr = shift;

  my $sum = 0;
  my $len = scalar(@$arr) - 1;

  foreach my $x (0..$len){
    $sum += @$arr[$x];
  }

  my $amrnd = sprintf("%.1f", $sum / ($len + 1));
  print "AM = " . $amrnd . "  ";
}

sub geometric {
  my $arr = shift;

  my $prod = 0;
  my $len = scalar(@$arr) - 1;

  foreach my $x (0..$len){
    if ($prod == 0 ) {
      $prod = @$arr[$x];
    } else {
      $prod *= @$arr[$x];
    }
  }

  my $gmrnd = sprintf("%.1f", $prod ** (1/($len+1)));

  print "GM = " . $gmrnd . "  ";
}

sub harmonic {
  my $arr = shift;

  my $len = scalar(@$arr) - 1;
  my $sum = 0;

  foreach my $x (0..$len){
    $sum += 1/@$arr[$x];
  }

  my $hmrnd = sprintf("%.1f", ($len+1)/$sum);
  say "HM = " . $hmrnd . "  ";
}

my @inp = qw(1 2 3 4 5);

arithmetic(\@inp);
geometric(\@inp);
harmonic(\@inp);
