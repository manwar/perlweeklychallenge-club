
  
use v5.38;

  
sub count_even_digits{
    return 0 + 
      grep { 
        my $x = $_; $x =~ tr/[0-9]//d  % 2 == 0 
      } @_;
}

  
MAIN:{
  say count_even_digits 10, 1, 111, 24, 1000;
  say count_even_digits 111, 1, 11111;
  say count_even_digits 2, 8, 1024, 256;
}

