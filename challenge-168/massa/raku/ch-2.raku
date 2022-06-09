use v6;

my sub factors(int \x is copy) {
  my int $possible-factor = 2;
  gather {
    while x > 1 {
      if $possible-factor.is-prime && x %% $possible-factor {
        take $possible-factor;
        x div= $possible-factor
      } else {
        Nil until is-prime ++$possible-factor
      }
    }
  }
}

my sub hp(int \x is copy) {
  loop {
    given +[~] factors x {
      .return if .is-prime;
      x = $_
    }
  }
}

sub MAIN(Int() \n where * > 1) {
  say hp n
}
