sub prime_count (Int $n) {
  return (2..$n).grep(&is-prime).elems;
}

say prime_count 10;
say prime_count 15;
say prime_count 1;
say prime_count 25;
say prime_count 2;
