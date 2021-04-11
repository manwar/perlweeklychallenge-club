unit sub MAIN () ;

sub sd (Int $base) {

    $base == any(2,3,6) and return -1;

    (($base-4)*($base**($base-1)) + 2*($base**($base-2)) + $base**($base-3) + $base**3)
        .base($base);

}


say sd($_) for 2..36;
