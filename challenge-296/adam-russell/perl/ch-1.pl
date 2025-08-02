
  
use v5.40; 

  
sub encoding{
    my($s) = @_;
    my $count = 0;
    my $encoding = q//;
    $s = [split //, $s];
    
  my $previous = q//;
  {
      my $c = shift @{$s};
      $count++ if $c eq $previous;
      if($c ne $previous){
          
  $encoding .= "$count$previous" if $count > 1;
  $encoding .= $previous if $count == 1;

          $count = 1; 
      }
      $previous = $c;
      redo if 0 < @{$s};
  } 
  
  $encoding .= "$count$previous" if $count > 1;
  $encoding .= $previous if $count == 1;


    return $encoding;
}

  
sub decoding{
    my($s) = @_;
    my $decoded = q//;
    $s = [split //, $s];
    
  my $previous = q//;
  {
      my $c = shift @{$s};
      if($c =~ m/\d/){
          my $d = $c;
          $c = shift @{$s};
          $decoded .= $c x $d;
      }
      else{
          $decoded .= $c;
      }
      redo if 0 < @{$s};
  } 

    return $decoded;
}

  
MAIN:{
  say encoding q/abbc/;
  say encoding q/aaabccc/;
  say encoding q/abcc/;
  
  say q//;
  
  say decoding encoding q/abbc/;
  say decoding encoding q/aaabccc/;
  say decoding encoding q/abcc/;
}

