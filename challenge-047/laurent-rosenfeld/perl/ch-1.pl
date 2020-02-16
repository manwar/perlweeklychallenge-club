use strict;
use warnings;
use feature qw/say/;


my %rom_tab = (I => 1,  V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000);

sub from_roman {
    my $roman = uc shift;
    my $numeric = 0;
    my $prev_letter = "M";
    for my $letter (split //, $roman) {
        $numeric -= 2 * $rom_tab{$prev_letter}
            if $rom_tab{$letter} > $rom_tab{$prev_letter};
        $numeric += $rom_tab{$letter};
        $prev_letter = $letter;
    }
    return $numeric;
}

sub to_roman {
    my $arabic = shift;
    warn "$arabic out of bounds" unless $arabic > 0 and $arabic < 4000;
    my %hash = %rom_tab;
    $hash{$_->[0]} = $_->[1] for (['IV', 4], ['IX', 9], ['XL', 40],
        ['XC', 90], ['CD', 400], ['CM', 900] );
    my $roman = "";
    for my $key (sort { $hash{$b} <=> $hash{$a} } keys %hash) {
        my $num = int ($arabic / $hash{$key});
        $roman .= $key x $num;
        $arabic -= $hash{$key} * $num;
    }
    return $roman;
}

my @input;
for (@ARGV) {
    push @input, $_ if /[-+*\/]/;
    push @input, from_roman $_ if /[ivxlcdm]+/i;
}
die "Need at least three parameters" if @input < 3; # we need at least 1 operator and two operands
my $result = eval join ' ', @input;
say "@ARGV = ", to_roman $result;
