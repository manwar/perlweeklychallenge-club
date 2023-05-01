#!/usr/bin/perl
use 5.030;
use warnings;

sub findHighest {
   my @numbers = @_;
   my $highestScore = 0;
   for my $i (0 .. scalar @numbers - 1) {
    my ($points, @rest) = removeConsecutive($i, @numbers);
    my $score = $points + findHighest(@rest);
      if ($score > $highestScore) {
         $highestScore = $score;
      }
   }
   return $highestScore;
}

sub removeConsecutive {
   my $i = shift;
   my @numbers = @_;
   
   my $current = $numbers[$i];
   my $quantity = 0;

    for my $n ($i .. scalar @numbers - 1) {
        if ($numbers[$n] != $current) {
            last;
        } else {
            $quantity++;
        }
    }
    splice @numbers, $i, $quantity;

    return ($quantity * $quantity, @numbers);
}

my @numbers = @ARGV;
say findHighest(@numbers);

