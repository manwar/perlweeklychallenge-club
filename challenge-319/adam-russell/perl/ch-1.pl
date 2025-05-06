
  
use v5.40; 

  
  sub word_count{
      return 0 + grep { 
  $_ =~ m/^[aeiou]/ || $_ =~ m/.*[aeiou]$/
} @_;
  }

  
MAIN:{
  say word_count qw/unicode xml raku perl/;
  say word_count qw/the weekly challenge/;
  say word_count qw/perl python postgres/;
}

