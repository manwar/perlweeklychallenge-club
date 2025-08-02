
  
use v5.38;

  
sub search_multiply{
  my($start) = shift;
  return $start if 0 == grep {$start == $_} @_;
  search_multiply($start + $start, @_);
}

  
MAIN:{
  say search_multiply 3, 5, 3, 6, 1, 12;
  say search_multiply 1, 1, 2, 3, 4;
  say search_multiply 2, 5, 6, 7;
}  

