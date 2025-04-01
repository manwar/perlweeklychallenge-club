
  
use v5.40; 

  
  sub loop_compare{
      my($n, $s) = @_;
      my @n = split //, $n;
      my @s = split //, $s;
      my $current_n  = q//;
      my $current_s = q//;
      { 
          my $previous_n = $current_n;
          $current_n = shift @n;
          $current_s = shift @s;
          if($current_s ne $current_n && $current_s eq $previous_n){
              unshift @n, $current_n;
              {
                  $current_s = shift @s;
                  redo if $current_s eq $previous_n && @s > 0;
                  unshift @s, $current_s;
              }
          }
          return 0 if $current_s ne $current_n && $current_s ne $previous_n;
          redo if @n > 0 && @s > 0;
      }
      return 1 if (@n == 0 && @s ==0) || (@s == grep {$_ eq $current_s} @s);
      return 0;
  }

  
MAIN:{
  say loop_compare q/perl/, q/perrrl/; 
  say loop_compare q/raku/, q/rrakuuuu/; 
  say loop_compare q/python/, q/perl/; 
  say loop_compare q/coffeescript/, q/cofffeescccript/; 
}

