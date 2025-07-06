
  use v5.40;
  
  sub replace_all{
      my($s) = @_;
      my @s = split //, $s;
      my @r = ();
      {
          my $c = shift @s;
          my $before = pop @r;
          my $after = shift @s;
          my $replace;
          if($c eq q/?/){
              
  do{
      $replace = chr(int(97 + rand(123 - 97)));
      $replace = undef if $before && $replace eq $before;
      $replace = undef if $after && $replace eq $after;
  } while(!$replace);

              push @r, $before, $replace if $before;
              push @r, $replace if !$before;
          }
          else{
              push @r, $before, $c if $before;
              push @r, $c if !$before;
          }
          unshift @s, $after if $after;
          redo if $after;
      }
      return join q//, @r;
  }

  
MAIN:{
    say replace_all q/a?z/;
    say replace_all q/pe?k/;
    say replace_all q/gra?te/;
} 

