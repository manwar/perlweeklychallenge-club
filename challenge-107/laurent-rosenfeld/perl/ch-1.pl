use strict;
use warnings;
use feature qw /say/;
use constant DIGITS => ('0'..'9', 'A'..'Z');
use constant MAX => 3;
my $count = 0;

sub to_base_b { # Converts decimal number to base b string
    my($dec, $base) = @_;
    my @digits;
    while ($dec) {
        unshift @digits, (DIGITS)[$dec % $base];
        $dec = int($dec/$base);
    }
    return join "", @digits;
}

sub check_self_desc {
    my $base = shift;
    for my $num ($base ** ($base -1) .. $base ** $base -1) {
        my $num_in_b = to_base_b ($num, $base);
        next unless $num_in_b =~ /0$/;
        my @digits = split //, $num_in_b;
        my $sum = 0;
        $sum += $_ for split //, $num_in_b;
        next if $sum != $base;
        my $success = 1;
        for my $rank (0..$base - 1) {
            my $nb_digits = $digits[$rank];
            my $num_occ = $num_in_b =~ s/$rank/$rank/g;
            if ($num_occ != $nb_digits) {
                $success = 0;
                last;
            }
        }
        if ($success) {
            say "Number in base $base: $num_in_b; decimal: $num" ;
            $count++;
            return if $count >= MAX;
        }
    }
}

for my $base (2..10) {
    check_self_desc($base);
    last if $count >= MAX;
}
