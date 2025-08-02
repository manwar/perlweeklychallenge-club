use strict;
use warnings;
use Data::Dumper;

sub ascii_calculate {

  my $str = @_[0];
  print "str: $str \n";
  my $sum;
  my $ascii_op;
  my @strings = split("",$str);

  for(my $i; $i<((scalar @strings)-1); $i++){
    $ascii_op = abs(ord($strings[$i]) - ord($strings[$i+1]));
    $sum += $ascii_op; 
  }
  return $sum;
}

my $word_1 = ascii_calculate('hello');
my $word_2 = ascii_calculate('perl');
my $word_3 = ascii_calculate('raku');

print "hello : $word_1 / perl : $word_2 / raku: $word_3 \n";