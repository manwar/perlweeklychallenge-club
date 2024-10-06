
  
use v5.40;

  use Algorithm::Permute; 
  
sub jumble{
  return map {
    my $w = [split //, $_];
    
  my $stripped = [];
  my $punctuation = [];
  do{
      $punctuation->[$_] = $w->[$_] if $w->[$_] =~ m/[[:punct:]]/;
      push @{$stripped}, $w->[$_] if $w->[$_] !~ m/[[:punct:]]/;
  } for 0 .. @{$w} - 1;

    
  my $p = Algorithm::Permute->new(
      [@{$stripped}[1 .. @{$stripped} - 2]]
  );
  my @p;
  if(@{$stripped} > 2){
    my @r = $p->next();
    { 
      push @p, [@r];
      @r = $p->next();
      redo if @r;
    }
    $stripped = [$stripped->[0] , 
                 @{$p[rand @p]} , 
                 $stripped->[@{$stripped} - 1]];
  }
  $stripped = join q//, @{$stripped};

    
  do{
      substr $stripped, $_, 0, $punctuation->[$_] 
        if $punctuation->[$_];
  } for 0 .. @{$punctuation} - 1;
  $stripped . q/ /;

  } @_;
}

  
MAIN:{
  say q/in the ASCII range match all non-controls./;
  say jumble qw/in the ASCII range match all non-controls./;
  say q//;
  say q/This handy module makes performing permutation.../;
  say jumble qw/This handy module makes performing permutation.../;
}

