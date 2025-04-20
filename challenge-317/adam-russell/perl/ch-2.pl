
  
use v5.40; 

  sub friendly{
      my($u, $v) = @_;
      
  my $differences = [];
  my @u = split //, $u; 
  my @v = split //, $v;
  {
      my $u_ = pop @u;
      my $v_ = pop @v;
      push @{$differences}, [$u_, $v_] unless $u_ eq $v_;
      redo unless !@u || !@v;
  }

      
  return 1 if @{$differences} == 0; 
  return 0 if @{$differences} == 1 || @{$differences} > 2;    
  my @s = sort {$a cmp $b} @{$differences->[0]}; 
  my @t = sort {$a cmp $b} @{$differences->[1]};
  return 1 if $s[0] eq $t[0] && $s[1] eq $t[1];
  return 0;       

  }
  
MAIN:{
  say friendly q/desc/, q/dsec/;
  say friendly q/cat/, q/dog/;
  say friendly q/stripe/, q/sprite/;
}

