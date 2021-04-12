use warnings;
use strict;
use feature ":5.26";

use bigint;

## ## ## ## ## MAIN

my $base;

say "derived numbers:";
for $base (2..39){
    printf "%2d     %s\n", $base, self_descriptive($base);
}

say "";

say "assembled numbers:";
for $base (7..39){
    printf "%2d     %s\n", $base, self_descriptive_assembled($base);
}

sub self_descriptive {
## formula for creating self-descriptive numbers for a given base ( returns undef for 2, 3 and 6, which have no numbers )
    my $base = shift;
    return undef if $base == 2 or $base == 6;
    return 100   if $base == 3;
    my $dec = ($base-4)*($base**($base-1)) + 2*($base**($base-2)) + $base**($base-3) + $base**3;
    my @alphanum = (0..9, 'A'..'Z');
    my $out = "";
    my $rem;
    while ( $dec > 0 ) {
        ($dec, $rem) = (int( $dec/$base ), $dec % $base);
        $out = $alphanum[$rem] . $out;
    }
    return $out;
}

sub self_descriptive_assembled {
## or we can just assemble a graphical representation of a number manually that will fit the bill
## only for b > 6;
    my $base = shift;
    my @alphanum = (0..9, 'A'..'Z');
    my $out = $alphanum[$base-4] . "21" . "0" x ($base-7) . "1000";
    return $out;
}
