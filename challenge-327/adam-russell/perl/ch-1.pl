
  use v5.40;
  
  sub find_missing{
      my %h = ();
      my @missing = ();
      do{ $h{$_} = -1 } for @_;
      @missing = grep {!exists($h{$_})} 1 .. @_;
      return @missing;
  }

  
MAIN:{
    say q/(/ . join(q/, /, find_missing 1, 2, 1, 3, 2, 5) . q/)/;
    say q/(/ . join(q/, /, find_missing 1, 1, 1) . q/)/;
    say q/(/ . join(q/, /, find_missing 2, 2, 1) . q/)/;
} 

