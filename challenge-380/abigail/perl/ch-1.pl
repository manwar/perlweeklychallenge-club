#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my %count;
    $count {$_} ++ for $line =~ /[a-z]/g;
    my $max_c = 0;
    my $max_v = 0;
    while (my ($letter, $count) = each %count) {
        my $cmp = $letter =~ /[aeiou]/ ? \$max_v : \$max_c;
          $$cmp = $count if $$cmp < $count;
    }
    say $max_c + $max_v;
}

__END__
