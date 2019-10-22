#Create a function to check divide by zero error 
#without checking if the denominator is zero.

sub div_zero_check ($n, $d) {
    my $r;
    try {
        $r = $n / $d;
        
        #Error is not raised when the result of division is not used
        say $r;
    }
    
    $! && say "Division by zero detected";
}

div_zero_check(112,0);
div_zero_check(0,0);
div_zero_check(0,1);
div_zero_check(32,12);