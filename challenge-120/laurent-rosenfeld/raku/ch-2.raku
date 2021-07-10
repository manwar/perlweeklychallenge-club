use v6;

sub find-angle (Str $t) {
    my ($h, $m) = split /\:/, $t;
    # We compute angles in degrees from 0h00 and clockwise
    my $m-angle = $m * 6;  # or: $m * 360/60
    my $h-angle = ($h * 360/12 + $m-angle / 12) % 360;
    my $angle = abs ($m-angle - $h-angle);
    return $angle <= 180 ?? $angle !!  360 - $angle;
}
for <03:10 04:00 07:00 15:10 20:44> -> $test {
    say "$test: ", find-angle $test;
}
