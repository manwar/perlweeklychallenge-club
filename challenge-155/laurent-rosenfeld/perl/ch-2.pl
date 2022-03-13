use strict;
use warnings;
use feature "say";

my @fibmod = (1, 1);
$fibmod[$_] = ($fibmod[$_-1] + $fibmod[$_-2]) % 3 for 2..30;
my $seq = join '', @fibmod[0..30];
# say $seq; # 1120221011202210112022101120221
my $repeated = $1 if $seq =~ /(.+)\1+/;
say length $repeated;
