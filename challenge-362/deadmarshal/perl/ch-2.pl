#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub to_en{
  my ($n) = @_;
  return 'minus ' . to_en(-$n) if $n < 0;
  my @units = qw(zero one two three four five six seven eight nine);
  my %teens = (10 => 'ten',11 => 'eleven',12 => 'twelve',
	       13 => 'thirteen',14 => 'fourteen', 15 => 'fifteen',
	       16 => 'sixteen',17 => 'seventeen', 18 => 'eighteen',
	       19 => 'nineteen');
  my %tens = (20 => 'twenty',30 => 'thirty', 40 => 'forty',
	      50 => 'fifty',60 => 'sixty',70 => 'seventy',
	      80 => 'eighty',90 => 'ninety');

  return $units[$n] if $n < 10;
  return $teens{$n} if $n < 20;

  if($n < 100) {
    my $t = int($n / 10) * 10;
    my $u = $n % 10;
    return $u == 0 ? $tens{$t} : "$tens{$t}-$units[$u]"
  }

  if($n < 1000) {
    my $h = int($n/100);
    my $r = $n % 100;
    my $base = "$units[$h] hundred";
    return $r == 0 ? $base : "$base and " . to_en($r)
  }
  
  if($n < 1_000_000) {
    my $th = int($n/1000);
    my $r = $n % 1000;
    my $base = to_en($th) . ' thousand';
    return $r == 0 ? $base : "$base " . to_en($r)
  }

  die "Number is out of supported range\n"
}

sub spellbound_sorting{
  my ($arr) = @_;
  my %words;
  foreach my $n(@$arr){$words{$n} = to_en($n)}
  sort {$words{$a} cmp $words{$b}} @$arr
}

show spellbound_sorting([6,7,8,9,10]);
show spellbound_sorting([-3,0,1000,99]);
show spellbound_sorting([1,2,3,4,5]);
show spellbound_sorting([0,-1,-2,-3,-4]);
show spellbound_sorting([100,101,102]);

