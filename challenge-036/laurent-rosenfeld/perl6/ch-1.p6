use v6;

sub validate (Str $vin) {
    return False if $vin ~~ /<[OIQ]>/;
    return False unless $vin ~~ /^ <[A..Z0..9]> ** 17 $/;
    return check-digit $vin;
}

sub check-digit (Str $vin) {
    my %translations =
     A => 1, B => 2, C => 3, D => 4, E => 5, F => 6, G => 7, H => 8,
     J => 1, K => 2, L => 3, M => 4, N => 5, P => 7, R => 9, S => 2,
     T => 3, U => 4, V => 5, W => 6, X => 7, Y => 8, Z => 9;
    %translations{$_} = $_ for 0..9;
    my @weights = 8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2;
    my $i = 0;
    my $sum = sum map { %translations{$_} * @weights[$i++]}, $vin.comb;
    my $mod = $sum % 11;
    $mod = 'X' if $mod == 10;
    return True if $mod eq substr $vin, 8, 1;
    return False;
}

sub MAIN (Str $vin = "1M8GDM9AXKP042788") {
    say validate($vin) ?? "Correct" !! "Wrong";
}
