use v6;

sub MAIN (Numeric $numerator, Numeric $denominator) {
    try {
        say "Result of division is: ", $numerator / $denominator;
    } or say "Houston, we've had a problem here: ",  $!.Str;
}
