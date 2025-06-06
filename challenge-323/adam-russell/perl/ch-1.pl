
  
  use v5.40;
  use IncrementDecrement;
  
use constant TEST0 => q/--x x++ x++/;
use constant TEST1 => q/x++ ++x x++/; 
use constant TEST2 => q/x++ ++x --x x--/; 
use constant COMPLEX_TEST => <<~END_TEST;
    a b c
    a++ b++ c++
    ++a ++b ++c
    --a --b --c
    a-- b-- c--
    a++ ++b c++
    END_TEST


  
  sub print_variables{
      my($results) = @_;
      for my $k (keys %{$results}){
          print $k;
          say qq/:\t$results->{$k}/;
      }
  }

  
MAIN:{
  my $parser = IncrementDecrement->new();
  say TEST0; 
  say print_variables $parser->parse(TEST0); 
  say TEST1; 
  $parser->clear();
  say print_variables $parser->parse(TEST1); 
  say TEST2; 
  $parser->clear();
  say print_variables $parser->parse(TEST2); 
  say COMPLEX_TEST;
  $parser->clear();
  say print_variables $parser->parse(COMPLEX_TEST);
} 

