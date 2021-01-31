use v6;
constant $default = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
constant $min = 'A'.ord;
constant $max = 'Z'.ord;

sub MAIN (Str $in-string = $default, Int $shift = 3) {
    say rotate($in-string.uc, $shift);
    #say $out;
}
sub rotate ($in, $shift) {
    return join "",
        map { my $let= $_ - $shift;
              $let +=  26 if $let < $min;
              $min <= $_ <= $max ?? $let.chr !! $_.chr;
            }, $in.comb>>.ord;
}
