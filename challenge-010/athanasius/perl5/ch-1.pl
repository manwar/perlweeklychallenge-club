use strict;
use warnings;
use Const::Fast;

const my @ROMAN_NUMERALS =>
         (
             # ---Numeral---   Subtractive
             # Symbol  Value   Combination   Threshold
             [  'M',   1_000,     undef,       undef  ],
             [  'D',     500,      'CM',        900   ],
             [  'C',     100,      'CD',        400   ],
             [  'L',      50,      'XC',         90   ],
             [  'X',      10,      'XL',         40   ],
             [  'V',       5,      'IX',          9   ],
             [  'I',       1,      'IV',          4   ],
         );

const my @SUBTRACTIVE_COMBINATIONS =>
         (
             [ 'CM', 'N' ], [ 'CD', 'E' ], [ 'XC', 'B' ],
             [ 'XL', 'K' ], [ 'IX', 'W' ], [ 'IV', 'U' ],
         );

const my %DICTIONARY =>
         (
                       I =>     1,
             U =>   4, V =>     5,
             W =>   9, X =>    10,
             K =>  40, L =>    50,
             B =>  90, C =>   100,
             E => 400, D =>   500,
             N => 900, M => 1_000,
         );

$| = 1;

MAIN:
{
    printf "\nThe Roman numeral number %s is %d in decimal\n",
             'CCXLVI', roman2decimal('CCXLVI');

    printf "\nThe decimal number %d is %s in Roman numerals\n",
              39, decimal2roman(39);
}

sub roman2decimal
{
    my ($roman)   =  @_;
        $roman    =~ s/ $_->[0] /$_->[1]/ix for @SUBTRACTIVE_COMBINATIONS;
    my  $decimal  =  0;
        $decimal +=  $DICTIONARY{$_} for split //, $roman;

    return $decimal;
}

sub decimal2roman
{
    my ($decimal) = @_;
    my  $roman    = '';

    for (@ROMAN_NUMERALS)
    {
        my ($symbol, $value, $sub_comb, $threshold) = @$_;

        if (defined $threshold && $decimal >= $threshold)
        {
            $roman   .= $sub_comb;
            $decimal -= $threshold;
        }
        else
        {
            my $quotient = int($decimal / $value);

            $roman   .= $symbol x $quotient;
            $decimal -= $value  * $quotient;
        }
    }

    return $roman;
}

