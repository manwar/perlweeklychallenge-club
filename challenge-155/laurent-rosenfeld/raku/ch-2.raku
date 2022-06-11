my @fibmod = 1, 1, (* + *) % 3 ... *;
my $seq = @fibmod[0..30].join('');
# say $seq; # 1120221011202210112022101120221
my $repeated = $0 if $seq ~~ /(.+) $0+/;
say $repeated.chars;
