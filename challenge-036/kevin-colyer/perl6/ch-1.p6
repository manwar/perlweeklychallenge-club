#!/usr/bin/perl6
use v6;

use Test;

=begin pod

Task 36.1

Write a program to validate given Vehicle Identification Number (VIN). For more information, please checkout

https://en.wikipedia.org/wiki/Vehicle_identification_number

=end pod

my %value=
    A => 1, B => 2, C => 3, D => 4, E => 5, F => 6, G => 7, H => 8,
    J => 1, K => 2, L => 3, M => 4, N => 5, P => 7, R => 9, S => 2,
    T => 3, U => 4, V => 5, W => 6, X => 7, Y => 8, Z => 9, "_" => 0,
    0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9;
    # I, O, and Q  not valid. Numbers are own value
    # check digit of _ = 0. Subsitute check digit for a 0 to calculate.
    # check digit is #9
    # vin is 17 chars long

my @weight=8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2;

sub validateVIN($vin is copy) {
    my @v= $vin.uc.comb;
    return "invalid vin character: I,O or Q"     if $vin ~~ m:i/ <[ I O Q ]>+ /;
    return "invalid vin length {$vin.chars}" if $vin.chars != 17;

    my $check=@v[8];
    $check = 0  if $check eq '_';
    $check = 10 if $check eq 'X';
    my $i=0;

    for ^17 {
        $i += %value{@v[$_]} * @weight[$_];
    };

    return $i % 11 == $check ?? "valid" !! "invalid - failed checksum" ;
}

#| Enter a Vehicle Identification Number to validate
multi MAIN(Str $vin) {
    say validateVIN($vin);
}

multi MAIN('test') {
    is validateVIN("111111111111111i1"),"invalid vin character: I,O or Q","invalid vin character: I,O or Q";
    is validateVIN("111111111111111111"),"invalid vin length 18","invalid vin length 18";
    is validateVIN("11111111111111111"),"valid","Vin is valid = all 1's'";
    is validateVIN("1M8GDM9A_KP042788"),"invalid - failed checksum","invalid - failed checksum";
    is validateVIN("1M8GDM9AXKP042788"),"valid","Vin is valid = wikipedia example";
done-testing;
}

