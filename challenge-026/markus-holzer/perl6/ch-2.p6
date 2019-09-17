use Test;

# Rakus trigonometry functions operate on radians. So we must convert degrees to radians.
# That's simple enough using a new postfix operator and high school math.
multi sub postfix:<°>( Numeric $degrees ) is looser(&prefix:<->) returns Real { $degrees * π / 180 }

# This implements the "simple" version of the algorithm as described on Wikipedia.
# There already is an implementation of the complex math version (that uses `i`)
# on Rosetta-Code https://rosettacode.org/wiki/Averages/Mean_angle#Perl_6
sub mean-angle( *@α ) returns Real
{
    # Neiter inv, nor ρ will ever change, so we can define them as immutable
    my \inv = 1 / @α.elems;
    my \ρ = atan2(
        (inv * [+] @α>>.sin), # calculate the sine of all angles, sum the result and multiply that with the factor
        (inv * [+] @α>>.cos)  # same, but with cosine
    );

    ρ > 0
        ?? ρ         # We always want a positive value
        !! ρ + 2 * π # When it isn't, we add 360°
}

ok( mean-angle( 10°, 10°, 10° )         =~= 10°,  "The mean of equal angles is the angle" );
ok( mean-angle( 10°, 20°, 30° )         =~= 20°,  "All angles in one quadrant" );
ok( mean-angle( 355°, 5°, 15° )         =~= 5°,   "Angles in multiple quadrants" );
ok( mean-angle( 90°, 180°, 270°, 360° ) =~= 270°, "Angle is not negative" );
