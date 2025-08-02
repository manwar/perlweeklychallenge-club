
  use v5.40;
  
  sub bad_pair{
      my($s) = @_;
      my @s = split q//, $s;
      return undef if !@s;
      {
          my($x, $y) = (ord shift @s, ord shift @s);
          if($x == $y + 32 || $x == $y - 32){
              return chr($x) . chr($y);
          }
          unshift @s, chr($y);
          redo unless @s == 1;
      }
      return undef;
  }

  
  sub make_good{
      my($s) = @_;
      {
          my $bad_pair = bad_pair $s;
          $s =~ s/$bad_pair// if $bad_pair;
          redo if bad_pair $s;
      }
      return $s;
  }

  
MAIN:{
    say make_good q/WeEeekly/;
    say make_good q/abBAdD/;
    say make_good q/abc/;
}

