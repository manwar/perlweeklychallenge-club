use strict;
use warnings;
use feature qw /say/;
use constant DIGITS => ('0'..'9', 'A'..'Z');

sub to_base_b {
    my($dec, $base) = @_;
    my @digits;
    while ($dec) {
        unshift @digits, (DIGITS)[$dec % $base];
        $dec = int($dec/$base);
    }
    return join "", @digits;
}
sub check_all_cases {
    my $base = shift;;
    for my $num ($base ** ($base -1) .. $base ** $base -1) {
        my $num_in_b = to_base_b ($num, $base);
        my @digits = split //, $num_in_b;
        my $success = 1;
        for my $rank (0..$base - 1) {
            my $nb_digits = $digits[$rank];
            my $num_occ = $num_in_b =~ s/$rank/$rank/g;
            if ($num_occ != $nb_digits) {
                $success = 0;
                last;
            }
        }
        say "Number in base $base: $num_in_b; decimal: $num"
            if $success;
    }
}
my $base = shift;
check_all_cases($base);
