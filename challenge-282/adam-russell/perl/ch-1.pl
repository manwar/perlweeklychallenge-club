
  
use v5.38;

  
sub good_integer{
    my($x) = @_;
    return qq/$1$2/ if $x =~ m/([0-9])(\1{2,})/ && 
                       length qq/$1$2/ == 3;  
    return -1;
}

  
MAIN:{
  say good_integer q/12344456/;
  say good_integer q/1233334/;
  say good_integer q/10020003/;
}

