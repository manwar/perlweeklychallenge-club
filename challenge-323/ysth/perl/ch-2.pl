use 5.036;

use JSON::XS 'decode_json';
use List::Util 'min';
use Math::BigRat ();

my $income = Math::BigRat->new(shift // 10);
my $brackets = decode_json(shift // '[[3, 50], [7, 10], [12,25]]');
push @$brackets, [Math::BigRat->binf, 0];

my $tax = 0;
$income = 0 if $income < 0;
my $bracket_start = 0;
for (;;) {
    my $bracket = shift @$brackets;
    my $final_bracket = $income <= $bracket->[0];
    my $bracket_amount = ($final_bracket ? $income : Math::BigRat->new($bracket->[0])) - $bracket_start;
    $tax += $bracket_amount * $bracket->[1] / 100;
    last if $final_bracket;
    $bracket_start = $bracket->[0];
}

say $tax->numify;
