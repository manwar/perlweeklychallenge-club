
  
use v5.40;

  
  sub sum_digits{
      my($x) = @_;
      if($x >= 10){
          my @a = split //, $x;
          return $a[0] + $a[1];
      }
      return $x;
  }

  
sub luhn{
    my($digits) = @_;
    my @digits = $digits =~ m/([0-9])/g;
    my $sum = 0;
    my $check = pop @digits;
    {
        my $x = pop @digits;
        my $y = pop @digits;
        if(defined $x && defined $y){
            $sum += $y + sum_digits 2 * $x;
        }
        else{
            $sum += sum_digits 2 * $x;
        }
        redo if @digits;
    } 
    return 1 if 0 == ($sum + $check) % 10;
    return 0;
}

  
MAIN:{
  say luhn q/17893729974/;
  say luhn q/4137 8947 1175 5904/;
  say luhn q/4137 8974 1175 5904/;
}

