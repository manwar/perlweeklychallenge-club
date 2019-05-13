my @perfect = lazy gather {
  my $q = 1;
  take $q*($q+1)/2 if (++($q+<=1)).is-prime while 1;
}

say @perfect[$_] for 0..19;
