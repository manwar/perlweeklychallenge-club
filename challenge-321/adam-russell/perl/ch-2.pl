
  
use v5.40; 

  
  sub backspace_compare{
      my($s, $t) = @_;
      my @s = split //, $s;
      my @t = split //, $t;
      my @u = ();
      my @v = ();
      {
          my $s_ = shift @s || undef;
          my $t_ = shift @t || undef;
          push @u, $s_ if $s_ && $s_ ne q/#/;
          push @v, $t_ if $t_ && $t_ ne q/#/;
          pop @u if $s_ && $s_ eq q/#/;
          pop @v if $t_ && $t_ eq q/#/;
          redo if @s || @t;
      }
      return join(q//, @u) eq join(q//, @v)?q/true/:q/false/;
  }

  
MAIN:{
  say backspace_compare q/ab#c/, q/ad#c/;
  say backspace_compare q/ab##/, q/a#b#/;
  say backspace_compare q/a#b/, q/c/;
}

