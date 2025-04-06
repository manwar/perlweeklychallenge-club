
  
use v5.40; 

  
  sub find_words{
      my($s, $c) = @_;
      return grep {$s->[$_] =~ m/$c/} 0 .. @{$s} - 1;
  }

  
MAIN:{
  say q/(/ . join(q/, /, find_words([q/the/, q/weekly/, q/challenge/], q/e/)). q/)/; 
  say q/(/ . join(q/, /, find_words([q/perl/, q/raku/, q/python/], q/p/)) . q/)/; 
  say q/(/ . join(q/, /, find_words([q/abc/, q/def/, q/bbb/, q/bcd/], q/b/)) . q/)/; 
}

