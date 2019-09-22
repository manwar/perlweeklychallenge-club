# Create a script that prints mean angles of the given list of angles in degrees. 
# Please read wiki(https://en.wikipedia.org/wiki/Mean_of_circular_quantities) page 
# that explains the formula in details with an example.

sub MAIN (
    *@angles   #= Angle(s) in degrees
){
    my ($x,$y) = (0,0);
    for @angles -> $r {
        $y += sin($r*π/180);
        $x += cos($r*π/180)
    }
    say atan2($y,$x)*180/π
}