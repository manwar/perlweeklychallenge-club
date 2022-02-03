use strict;
use warnings;

print "No args provided!\n" unless @ARGV == 2;
my ($s1, $s2) = @ARGV;

sub fibonacci_words{
  my (@arr) = @_;
  do{
    push @arr, $arr[-2] . $arr[-1];
  }while(length $arr[$#arr] < 52);

  return (split //, $arr[$#arr])[50];
}

print fibonacci_words($s1, $s2);
