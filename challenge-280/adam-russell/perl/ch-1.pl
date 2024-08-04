
  
use v5.38;

  
sub twice_appearance{
    my($s) = @_;
    my @a = ();
    do{
        $a[ord($_)]++;
        return $_ if $a[ord($_)] == 2;
    } for split //, $s;
    return undef;
}

  
MAIN:{
  say twice_appearance q/acbddbca/;
  say twice_appearance q/abccd/;
  say twice_appearance q/abcdabbb/;
}

