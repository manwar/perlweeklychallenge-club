package MyRoman;

use Exporter qw{ import };
our @EXPORT_OK = qw{ from_roman to_roman };

use warnings;
use strict;

my %from_roman = (
    I => 1,
    V => 5,
    X => 10,
    L => 50,
    C => 100,
    D => 500,
    M => 1000,
);
sub from_roman {
    my ($roman) = @_;
    my $n = 0;
    while ($roman =~ s/(I[VXLCDM]|X[LCDM]|C[DM])//) {
        my ($minus, $plus) = split //, $1;
        $n += $from_roman{$plus} - $from_roman{$minus};
    }
    $n += $from_roman{$_} for split //, $roman;
    return $n
}

my %to_roman = reverse %from_roman;
my %subtractive = (
    'IIII'  => 'IV',
    'VIIII' => 'IX',
    'XXXX'  => 'XL',
    'LXXXX' => 'XC',
    'CCCC'  => 'CD',
    'DCCCC' => 'CM',
);
my $subtractive_re = join '|',
                     sort { length $b <=> length $a }
                     keys %subtractive;
sub to_roman {
    my ($n) = @_;
    my $roman = "";
    while ($n) {
        for my $i (sort { $b <=> $a } keys %to_roman) {
            while ($n >= $i) {
                $n -= $i;
                $roman .= $to_roman{$i};
            }
        }
    }
    $roman =~ s/($subtractive_re)/$subtractive{$1}/g;
    return $roman
}

__PACKAGE__
