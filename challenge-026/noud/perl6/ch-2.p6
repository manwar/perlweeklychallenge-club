# Create a script that prints mean angles of the given list of angles in
# degrees. Please read wiki page that explains the formula in details with an
# example.

sub mean(@array) {
    @array.sum / @array.elems;
}

# Mean of circular quantities using atan2.
sub mean_angle(@angles) {
    atan2(mean(@angles.map(&sin)), mean(@angles.map(&cos)));
}

# Mean of circular quantities using complex numbers.
sub mean_angle2(@angles) {
    my $z = mean(@angles.map({ exp(i * $_) }));
    atan($z.im / $z.re);
}

# Mean of circular quantities using modulo over the circle
sub mean_angle3(@angles) {
    mean(@angles.map({ ($_ + pi) % (2 * pi) - pi }));
}

# Compute means in radians
mean_angle((0.1, 2 * pi + 0.2, -2 * pi + 0.3)).say;
mean_angle2((0.1, 2 * pi + 0.2, -2 * pi + 0.3)).say;
mean_angle3((0.1, 2 * pi + 0.2, -2 * pi + 0.3)).say;

# Wrap methods to convert degrees to radians
sub deg2rad($degree) {
    $degree * pi / 180;
}

sub rad2deg($rad) {
    $rad * 180 / pi;
}

&mean_angle.wrap: -> @arr { rad2deg(callwith(@arr.map(&deg2rad))) };
&mean_angle2.wrap: -> @arr { rad2deg(callwith(@arr.map(&deg2rad))) };
&mean_angle3.wrap: -> @arr { rad2deg(callwith(@arr.map(&deg2rad))) };

mean_angle((10, 20 + 360, 30 - 360)).say;
mean_angle2((10, 20 + 360, 30 - 360)).say;
mean_angle3((10, 20 + 360, 30 - 360)).say;
