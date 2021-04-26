# https://perlweeklychallenge.org/blog/perl-weekly-challenge-109/

# See: https://www.geeksforgeeks.org/find-divisors-natural-number-set-1/

#| Chowla Number
sub prefix:<ʗ>( Int $number ) returns Int {
  gather {
    (2 .. $number.sqrt).map({
      if $number %% $_ {
        take $_;
        take ($number / $_).Int;
      }
    });
  }.Seq.unique.sum;
}

# first $number of Chowla numbers
sub challenge( Int $number ) {
  (1..$number).map({ ʗ$_ });
}

multi sub MAIN( Int $number ) {
  say 'The first ',$number,' Chowla numbers are: ';
  say challenge($number);
}

multi sub MAIN( 'challenge' ) {
  MAIN(20);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is challenge(20), (0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21);

  done-testing;

}
