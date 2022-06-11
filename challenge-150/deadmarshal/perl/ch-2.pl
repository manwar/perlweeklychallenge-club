use strict;
use warnings;
use List::MoreUtils qw(uniq);

sub prime_factors{
  my ($num) = @_;
  my $c = 2;
  my @arr;
  while($num > 1){
    if($num % $c == 0){
      push @arr, $c;
      $num /= $c;
    }
    else{
      $c++;
    }
  }
  return @arr;
}

sub square_free_integers{
  my @arr;
  my $i = 1;
  do{
    my @primes = prime_factors($i);
    my $prime = uniq @primes;

    if(scalar(@primes) - $prime == 0){
      push @arr, $i;
    }
    $i++;
  }while(scalar @arr <= 500);

  return @arr;
}

print "$_ " foreach square_free_integers();
