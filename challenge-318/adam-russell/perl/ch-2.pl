
  
use v5.40; 

  sub reverse_equals{
      my($u, $v) = @_;
      my($s, $t) = ([@{$u}], [@{$v}]);
      
  my $indices_different = [];
  for my $i (0 .. @{$u} - 1){
      push @{$indices_different}, $i unless $u->[$i] eq $v->[$i];
  }

      
  return 1 if @{$indices_different} == 0;   
  $indices_different = [sort {$a <=> $b} @{$indices_different}];
  my $last_i = $indices_different->[@{$indices_different} - 1];
  my $length = 1 + $last_i - $indices_different->[0];
  my @u_ = reverse @{$u}[$indices_different->[0] .. $last_i];
  my @v_ = reverse @{$v}[$indices_different->[0] .. $last_i];
  splice @{$u}, $indices_different->[0], $length, @u_;
  splice @{$v}, $indices_different->[0], $length, @v_;
  return 1 if join(q/,/, @{$u}) eq  join(q/,/, @{$t});
  return 1 if join(q/,/, @{$v}) eq  join(q/,/, @{$s});
  return 0;

  }
  
MAIN:{
  say reverse_equals [3, 2, 1, 4], [1, 2, 3, 4];
  say reverse_equals [1, 3, 4], [4, 1, 3];
  say reverse_equals [2], [2];
}

