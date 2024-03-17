
  
use v5.38;
use boolean;

  
sub unique_occurrences{
  my %occurrences;
  do{ 
    $occurrences{$_}++;
  } for @_;
  my %h;
  do{$h{$_} = undef} for values %occurrences;
  return boolean(values %occurrences == keys %h); 
}

  
MAIN:{
  say unique_occurrences 1, 2, 2, 1, 1, 3;
  say unique_occurrences 1, 2, 3;
  say unique_occurrences -2, 0, 1, -2, 1, 1, 0, 1, -2, 9;
}

