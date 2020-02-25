use Test;
plan 6;

my $total = 11;
my @gap-v = 1, 2, 3, 4, 6;
my @rings = 
    { :color('Red'),    :v(9), :n(0) },
    { :color('Green'),  :v(5)        },
    { :color('Black')                },
    { :color('Yellow'), :v(7)        },
    { :color('Blue'),   :v(8), :m(0) };

@rings[0]<m> = @rings[1]<n> = find-x( @rings[0]<n>, @rings[0]<v> );
@rings[4]<n> = @rings[3]<m> = find-x( @rings[4]<m>, @rings[4]<v> );
@rings[1]<m> = @rings[2]<n> = find-x( @rings[1]<n>, @rings[1]<v> );
@rings[3]<n> = @rings[2]<m> = find-x( @rings[3]<m>, @rings[3]<v> );
@rings[2]<v> = find-x( @rings[2]<n>, @rings[2]<m> );

for @rings -> $ring
{
    ok $ring<m> + $ring<n> + $ring<v> == $total, "$ring<color> ring sum ok";
}

ok @gap-v.elems == 0, "all gap values in m processed";

say "Black value: @rings[2]<v>";

sub find-x( $gap, $v ) 
{
    my $j = $total - $v - $gap;
    my $i = @gap-v.first({ $_ == $j }, :k);
    die "Can't find index ($gap, $v)" unless $i.defined;
    @gap-v.splice( $i, 1 )[0];
}

dd @rings;

# Array @rings = [
#  {:color("Red"),    :m(2), :n(0), :v(9)}, 
#  {:color("Green"),  :m(4), :n(2), :v(5)}, 
#  {:color("Black"),  :m(1), :n(4), :v(6)}, 
#  {:color("Yellow"), :m(3), :n(1), :v(7)}, 
#  {:color("Blue"),   :m(0), :n(3), :v(8)} ]