
  use v5.40;
  
  sub decompress_list{
      my $r = shift @_; 
      if(!ref($r) || ref($r) ne q/ARRAY/){
          unshift @_, $r;
          $r = [];
      }
      unless(@_ == 0){ 
          my $i = shift @_;
          my $j = shift @_;
          push @{$r}, ($j) x $i;
          decompress_list($r, @_);
      }
      else{
          return @{$r};
      }
  }

  
MAIN:{
  say join q/, /, decompress_list 1, 3, 2, 4;
  say join q/, /, decompress_list 1, 1, 2, 2;
  say join q/, /, decompress_list 3, 1, 3, 2;
}

