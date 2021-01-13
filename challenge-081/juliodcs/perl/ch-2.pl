use strict;
use warnings;
use File::Slurp;
use List::AllUtils qw(reduce uniq);
use Const::Fast;
use experimental 'signatures';

const my $rx_words => qr/
    (?<!\p{L}')            # Don't match if preceded by word + ｢'｣
                           # (avoids matching ｢s｣ in ｢word's｣)
    \p{L}++ (?>-\p{L}+)*   # Match dash-separated words
    (?>'(?!s\b)\p{L}+)?    # It may end with ｢'｣ + word (except for ｢'s｣)
/ix;
const my @words    => read_file('input') =~ m/$rx_words/g;
const my %scores   => %{ +reduce { $a->{$b}++; $a } {}, @words };
const my $add      => sub($h, $w) { push $h->{$scores{$w}}->@*, $w; $h };
const my %inverse  => %{ +reduce { $add->($a, $b) } {}, keys %scores };

printf "$_ %s\n\n", join q( ), sort @{$inverse{$_}} for sort keys %inverse;
