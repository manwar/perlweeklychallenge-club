
  
use v5.40; 

  
sub reverse_letters{
    my($s) = (@_);
    $s = [split //, $s];
    my $reverse_letters = [];
    
  my $a = [grep {$_ =~ m/[[:alpha:]]/} @{$s}];

    
  $a = [reverse @{$a}];

    
  {
      my $c = shift @{$s};
      push @{$reverse_letters}, $c if $c !~ m/[[:alpha:]]/;
      push @{$reverse_letters}, shift @{$a} if $c =~ m/[[:alpha:]]/;
      redo if @{$s} > 0;
  }

    return join q//, @{$reverse_letters};
}

  
MAIN:{
  say reverse_letters q/p-er?l/;
  say reverse_letters q/wee-k!L-y/;
  say reverse_letters q/_c-!h_all-en!g_e/;
}

