
  
use v5.38;

  
sub defang{
    my($c, $defanged) = @_;
    $defanged = [] if !$defanged;
    return $defanged if @{$c} == 0;
    my $x = shift @{$c};
    if($x eq q/./){
        push @{$defanged}, q/[.]/;
    }
    else{
        push @{$defanged}, $x;
    }
    defang($c, $defanged);
}

  
MAIN:{
  say join(q//, @{defang([split //, q/1.1.1.1/])});
  say join(q//, @{defang([split //, q/255.101.1.0/])});
}

