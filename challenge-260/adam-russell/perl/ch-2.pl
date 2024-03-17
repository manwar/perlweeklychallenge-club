
  
use v5.38;
use boolean;

  
sub permutations{
  my($a, $k, $permutations) = @_;
  if($k == 1){
    push @{$permutations}, [@{$a}]; 
    return true;   
  } 
  else{
    permutations($a, $k - 1, $permutations); 
    for my $i (0 .. $k - 2){
      if($k & 1){
        ($a->[0], $a->[$k - 1]) = ($a->[$k - 1], $a->[0]);
      }
      else{
        ($a->[$i], $a->[$k - 1]) = ($a->[$k - 1], $a->[$i]);
      }
      permutations($a, $k - 1, $permutations); 
    }
  }
}

  
sub dictionary_rank{
  my($word) = @_;
  my $permutations = [];
  permutations [split //, $word], length($word), $permutations;
  my %h;
  do {$h{join q//, @{$_}} = undef} for @{$permutations};
  my @permutations = sort {$a cmp $b} keys %h;
  return (
    grep {$permutations[$_] eq $word} 0 .. @permutations - 1
  )[0] + 1;
}

  
MAIN:{
  say dictionary_rank q/CAT/;
  say dictionary_rank q/GOOGLE/;
  say dictionary_rank q/SECRET/;
}  

