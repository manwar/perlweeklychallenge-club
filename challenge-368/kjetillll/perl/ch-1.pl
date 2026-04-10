sub f {
    my( $str, $char, $max, $pre ) = @_;
    $str =~ /$char/
    ? f( $',
         $char,
         @_ == 2 || "$pre$`$'" > $max ? "$pre$`$'" : $max,
         "$pre$`$char" )
    : $max
}

print f( @$_{'str', 'char'} ) eq $$_{expected_output}
? "ok\n"
: "ERROR \n".f( @$_{'str', 'char'} )
  for
  { str => "15456",  char => "5", expected_output => "1546"  },
  { str => "7332",   char => "3", expected_output => "732"   },
  { str => "2231",   char => "2", expected_output => "231"   },
  { str => "543251", char => "5", expected_output => "54321" },
  { str => "1921",   char => "1", expected_output => "921"   };

# https://theweeklychallenge.org/blog/perl-weekly-challenge-368/
