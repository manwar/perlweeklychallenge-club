
  
use v5.40; 

  
  sub subsequence{
      my($s0, $s1) = @_;
      
  my($s, $t) = length $s0 > length $s1? ($s1, $s0): ($s0, $s1);             

      
  my $pattern = join q/.*/, split //, $s;       
  my $regex = qr/^.*$pattern.*$/;          

      return 0 + $t =~ $regex;
  }

  
MAIN:{
  say subsequence q/uvw/, q/bcudvew/;
  say subsequence q/aec/, q/abcde/;
  say subsequence q/sip/, q/javascript/;
}

