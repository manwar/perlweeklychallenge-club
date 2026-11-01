#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';


while (my $line = <>) {
    my $sum  = 0;
       $sum += $_ for my @numbers = sort {$a <=> $b} split /\s+/ => $line;
    my $res  = $sum <= 0 ? 1 : 1 + int ($sum / @numbers);
    for my $num (@numbers) {
        $res ++ if $num == $res;
        last    if $num >  $res;
    }
    say $res;
}

__END__
