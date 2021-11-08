
    
        use strict;
        use warnings;
    
    
        sub nth_root{
            my($n, $k) = @_;
            my $x_i = int(rand(10) + 1); 
            my $r;
            for my $i (0 .. 100){
                $x_i = (1 / $n) * (($n - 1) * $x_i + ($k / $x_i ** ($n - 1)));  
            } 
            return $x_i;  
        }
    
    
        sub integer_square_root{
            my($k) = @_;
            my $x = int(nth_root(2, $k));
            return $x;  
        }
    
    
        MAIN:{
            print integer_square_root(10) . "\n";
            print integer_square_root(27) . "\n";
            print integer_square_root(85) . "\n";
            print integer_square_root(101) . "\n";
        }

    
