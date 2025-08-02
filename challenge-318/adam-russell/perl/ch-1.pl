
  
use v5.40; 

  
  sub groupings{
      my($s) = @_;
      my @groups;
      my @group;
      my($current, $previous);
      my @letters = split //, $s;
      $previous = shift @letters;
      @group = ($previous);
      do {
          $current = $_;
          if($previous eq $current){
              push @group, $current;
          }
          if($previous ne $current){
              if(@group >= 3){
                  push @groups, [@group];
              }
              @group = ($current);
          }
          $previous = $current;
      } for @letters;
      if(@group >= 3){
          push @groups, [@group];
      }
      my @r = map {q/"/ . join(q//, @{$_}) . q/"/ } @groups;
      return join(q/, /, @r) || q/""/;
  }

  
MAIN:{
  say groupings q/abccccd/;
  say groupings q/aaabcddddeefff/;
  say groupings q/abcdd/;
}

