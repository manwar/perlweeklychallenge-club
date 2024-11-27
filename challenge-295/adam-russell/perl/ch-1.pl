
  
use v5.40; 
use boolean;

  
  sub find_breaks{
      my($s, $h) = @_; 
      return true if $s eq q//;
      my $c = substr $s, 0, 1;
      my $words = $h->{$c};
      do{
          $s = substr $s, length $_; 
          return find_breaks($s, $h);
      } for @{$words};
  }

  
sub word_break{
    my($s, $words) = @_;
    
  my $h = {};
  do{
      my $c = substr $_, 0, 1; 
      push @{$h->{$c}}, $_;
  } for @{$words};

    return boolean(find_breaks $s, $h);
}

  
MAIN:{
  say word_break q/weeklychallenge/, [q/challenge/, q/weekly/];
  say word_break q/perlrakuperl/, [q/raku/, q/perl/];
  say word_break q/sonsanddaughters/,[q/sons/, q/sand/, q/daughters/];
}

