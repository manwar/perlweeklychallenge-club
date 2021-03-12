#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub chinese_zodiac ($year) {
   my ($s, $y, $acbc) = $year =~ m{
      \A \s*
      (-?) \s*
      ([1-9]\d*) \s*
      ((?:ad|bc)?)
      \s* \z
   }imxs;
   die "invalid input date '$year'\n"
      if (! defined $y) || ($s eq '-' && length $acbc);
   $year = $s eq '-' || lc($acbc) eq 'bc' ? -$y : $y;
   my $r = $year > 0 ? (($year + 56) % 60) : 59 - ((2 - $year) % 60);
   my $yin_yang = (qw< Yang Yin >)[$r % 2];
   my $element  = (qw< Wood Fire Earth Metal Water >)[int($r / 2) % 5];
   my $animal   = (qw< Rat Ox Tiger Rabbit Dragon Snake
      Horse Goat Monkey Rooster Dog Pig >)[$r % 12];
   return ($yin_yang, $element, $animal);
}

my $y = "@ARGV" || 1972;
my ($yin_yang, $element, $animal) = chinese_zodiac($y);
say "$element $animal";
say {*STDERR} "$yin_yang $element $animal";
