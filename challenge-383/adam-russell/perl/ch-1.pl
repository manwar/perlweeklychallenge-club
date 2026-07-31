
  use builtin q/true/, q/false/;
  
  sub build_map{
      my($m) = @_;
      my $h = {};
      {
          my $l = pop @{$m};
          my $k = shift @{$l};
          for my $x (@{$l}){
              $h->{$x} = $k;
          }
          redo if @{$m};
      }
      return $h;
  }

  
  sub similar{
      my($u, $v, $m) = @_;
      
  return false if @{$u} ne @{$v};

      my $mapping = build_map($m);
      {
          my $vv = pop @{$v};
          my $uu = pop @{$u};
          return false unless($vv eq $uu || $mapping->{$vv} eq $uu 
                                         || $mapping->{$uu} eq $vv);
          redo if @{$u};
      }
      return true;
  }

  
MAIN:{
    print similar ["great", "acting"], 
                  ["fine", "drama"], 
                  [["great", "fine"], ["acting", "drama"]];
    print qq/\n/;
    print similar ["apple", "pie"], ["banana", "pie"], 
                  [["apple", "peach"], ["peach", "banana"]];
    print qq/\n/;
    print similar ["perl4", "python"], ["raku", "python"], 
                  [["perl4", "perl5", "raku"]];
    print qq/\n/;
    print similar ["enjoy", "challenge"], 
                  ["love", "weekly", "challenge"], 
                  [["enjoy", "love"]];
    print qq/\n/;
    print similar ["fast", "car"], 
                  ["quick", "vehicle"], 
                  [["quick", "fast"], ["vehicle", "car"]];
    print qq/\n/;
} 

