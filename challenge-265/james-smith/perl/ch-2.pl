sub completed_word {
  my ( %needle, $shortest );

  $needle{$_}++ for split //, (lc shift) =~ y{a-z}{}cdr;

  O: for( @_ ) {
    my %haystack;

    $haystack{$_}++ for split //, lc;

    $shortest = $_ unless
    ( defined $shortest && length $_ > length $shortest ) ||
      grep { ! exists $haystack{$_} || $needle{$_} > $haystack{$_} }
        keys %needle;
  }

  $shortest
}
