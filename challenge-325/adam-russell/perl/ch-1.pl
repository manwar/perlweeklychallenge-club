
  use v5.40;
  
  sub consecutive_one_r{ 
      my($i, $consecutive, $max_consecutive) = @_; 
      my $x;
      unless(@{$i} == 0){
          $x = pop @{$i};
          if($x == 0){
              $$max_consecutive = $$consecutive if $$consecutive > $$max_consecutive;
              $$consecutive = 0;
          }
          if($x == 1){
              $$consecutive++;
          }
          consecutive_one_r($i, $consecutive, $max_consecutive);
      }
      elsif(@{$i} == 1){
          $x = pop @{$i};
          if($x == 0){
              $$max_consecutive = $$consecutive if $$consecutive > $$max_consecutive;
          }
          if($x == 1){
              $$consecutive++;
              $$max_consecutive = $$consecutive if $$consecutive > $$max_consecutive;
          }       
          consecutive_one_r($i, $consecutive, $max_consecutive);     
      }
  }

  
  sub consecutive_one{
      my(@i) = @_;
      my($consecutive, $max_consecutive) = (0, 0);
      consecutive_one_r(\@i, \$consecutive, \$max_consecutive);
      return $max_consecutive;
  }

  
MAIN:{
    say consecutive_one(0, 1, 1, 0, 1, 1, 1);
    say consecutive_one(0, 0, 0, 0);
    say consecutive_one(1, 0, 1, 0, 1, 1);
} 

