# vi:et:sw=4 ts=4 ft=perl
#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use Math::MatrixReal;

my $n = shift;
my $matrix = Math::MatrixReal->new_diag([(1) x $n]);
$matrix->display_precision(0);
say $matrix;

1;

__END__

$ perl ch-2.pl 4
[  1           0           0           0          ]
[  0           1           0           0          ]
[  0           0           1           0          ]
[  0           0           0           1          ]
