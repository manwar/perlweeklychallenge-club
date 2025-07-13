
  use v5.40;
  
  sub is_nice{
      my ($s) = @_;
      my %seen;
      for my $c (split //, $s){
          if($c =~ m/[a-z]/) {
              $seen{$c}{lower} = 1;
          } 
          elsif($c =~ m/[A-Z]/) {
              $seen{lc($c)}{upper} = 1;
          }
      }
      for my $c (keys %seen){
          return 0 unless exists $seen{$c}{lower} && 
                          exists $seen{$c}{upper};
      }
      return 1; 
  }

  
  sub nice_substring{
      my ($s) = @_;
      my $n = length($s);
      my $longest = q//;
      for my $i (0 .. $n - 1) {
          for my $j ($i + 1 .. $n) {
              my $substring = substr($s, $i, $j - $i);
              if (is_nice($substring) && 
                  length($substring) > length($longest)){
                  $longest = $substring;
              }
          }
      }
      return $longest;
  }

  
MAIN:{
    say nice_substring q/YaaAho/;
    say nice_substring q/cC/;
    say nice_substring q/A/;
}

