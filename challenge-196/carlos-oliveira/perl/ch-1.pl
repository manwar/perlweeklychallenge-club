use strict;
use warnings;
use Data::Dump;

sub findThirdValue {
  my ($arrayRef, $firstValueIndex, $secondValueIndex) = @_;
  my @array = @$arrayRef;
  for my $i ($secondValueIndex+1 .. $#array) {
    return $array[$i] if $array[$i] < $array[$secondValueIndex]
      && $array[$i] > $array[$firstValueIndex];
  }
  return undef
}

sub findSecondAndThirdValues {
  my ($arrayRef, $firstValueIndex) = @_;
  my @array = @$arrayRef;
  for my $i ($firstValueIndex+1 .. $#array) {
    next unless $array[$firstValueIndex] < $array[$i];
    my $value3 = findThirdValue $arrayRef, $firstValueIndex, $i;
    return ($array[$i], $value3) if defined $value3;
  }
  return ();
}

sub pattern132 {
  for my $i (0 .. $#_) {
    my @remainingValues = findSecondAndThirdValues \@_, $i;
    return ($_[$i], @remainingValues) if @remainingValues > 0
  }
  return ();
}

dd pattern132(3, 1, 4, 2);
dd pattern132(1, 2, 3, 4);
dd pattern132(1, 3, 2, 4, 6, 5);
dd pattern132(1, 3, 4, 2);
