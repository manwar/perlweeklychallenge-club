#!/usr/bin/perl -l

print join ", " => binprime(1, 0, 1);
print join ", " => binprime(1, 1, 0);
print join ", " => binprime(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1);

sub binprime {
  my $n = 0;
  map {
    $n += $_[$_];
    $n <<= 1;
    !((1 x ($n>>1)) =~ /^.$|^(..+)\1+$/);
  } (0 .. $#_);
}
