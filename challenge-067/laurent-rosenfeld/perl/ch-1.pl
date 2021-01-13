use strict;
use warnings;
use feature qw /say/;

my $m = shift // 5;
my $num = shift // 2;
combinations([], 1..$m);

sub combinations {
    my ($out, @in) = @_;
    return unless @in;
    for my $digit (@in) {
        next if defined $out->[-1] and $digit <= $out->[-1];
        my $new_out = [ @$out, $digit ];
        say "@$new_out" and next if scalar @$new_out == $num;
        combinations($new_out, @in[1..$#in]);
    }
}
