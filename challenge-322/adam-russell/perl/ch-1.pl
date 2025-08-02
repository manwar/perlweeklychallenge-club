
  
use v5.40; 

  
  sub string_format{
      my($s, $i) = @_;
      my @s = split //, $s;
      my @t = ([]);
      {
          my $s_ = pop @s;
          unless($s_ eq q/-/){
              my $t_ = shift @t;
              if(@{$t_} == $i){
                  unshift @t, $t_;
                  unshift @t, [$s_];
              }
              else{
                  unshift @{$t_}, $s_;
                  unshift @t, $t_;
              }
          }
          redo if @s;
      }
      return join(q/-/, map {join q//, @{$_}} @t);
  }

  
MAIN:{
  say string_format q/ABC-D-E-F/, 3;
  say string_format q/A-BC-D-E/, 2;
  say string_format q/-A-B-CD-E/, 4;
}

