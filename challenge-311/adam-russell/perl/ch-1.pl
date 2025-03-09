
  
use v5.38;

  
sub upper_lower{
    my($s) = @_;
    my @c = split //, $s;
    return join q//, map{
        my $x = ord($_);
        if($x >= 65 && $x <= 90){
             chr($x + 32);
        }
        elsif($x >= 97 && $x <= 122){
            chr($x - 32);
        }
    } @c;
}

  
MAIN:{
  say upper_lower q/pERl/;
  say upper_lower q/rakU/;
  say upper_lower q/PyThOn/;
}

