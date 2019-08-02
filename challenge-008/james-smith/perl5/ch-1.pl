use feature qw(say);
use List::Util qw(notall);
my $q = 1;
foreach(1..7) {
  ($q<<=1)++; ## $q is a sequence of the form 2^n-1;
  redo if notall { $q%$_ } 2..($q-1); ## Only contine if $q is mersenne prime
  say $q*($q+1)/2;
}
