
  
use v5.40; 

  
  sub loop_pop_compare{
      my($s, $t, $u) = @_;
      my @s = split //, $s;
      my @t = split //, $t;
      my @u = split //, $u;
      my $counter = 0;
      { 
          my $max_size = (sort {$b <=> $a} (0 + @s, 0 + @t, 0 + @u))[0];
          unless(join(q//, @s) eq join(q//, @t) &&
                 join(q//, @t) eq join(q//, @u)){
              do{$counter++; pop @s} if @s == $max_size;
              do{$counter++; pop @t} if @t == $max_size;
              do{$counter++; pop @u} if @u == $max_size;
          }
          else{
              return $counter;
          }
          redo unless @s == 0 || @t == 0 || @u == 0;
      }
      return -1;
  }

  
MAIN:{
  say loop_pop_compare q/abc/, q/abb/, q/ab/; 
  say loop_pop_compare q/ayz/, q/cyz/, q/xyz/; 
  say loop_pop_compare q/yza/, q/yzb/, q/yzc/; 
}

