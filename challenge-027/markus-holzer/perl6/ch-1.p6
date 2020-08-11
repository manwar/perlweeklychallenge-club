multi sub MAIN( Int:D $x1, Int:D $y1, Int:D $x2, Int:D $y2, Int:D $x3, Int:D $y3, Int:D $x4, Int:D $y4 )
{
    with intersection( $x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4 ) -> ($x, $y) 
    { 
        say "The intersection is at $x, $y.";
    } 
    else 
    { 
        say .exception.message;
    }
}


sub intersection( Int \x1, Int \y1, Int \x2, Int \y2, Int \x3, Int \y3, Int \x4, Int \y4 )
{
    CATCH { default { fail "Lines are parallel or identical" } }
    
    return (
        eager # potential for division by zero, 
            ( (x1 * y2 - y1 * x2 ) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3*x4) ) div
            ( (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4) ),

        eager # without eager, laziness will bite us later
            ( (x1 * y2 - y1 * x2) * (y3 - y4) - (y1 -y2) * (x3*y4 - y3 * x4) ) div
            ( (x1 - x2) * (y3 - y4) - (y1 - y2) * (x2 - x4) )
    );
}
