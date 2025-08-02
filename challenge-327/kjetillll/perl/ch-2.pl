use warnings; use strict;

sub f {
    my @i = sort {$a<=>$b} @_;
    my $min='+Inf';
    my @result;
    for( 0 .. @i-2 ){
        my $diff = $i[$_+1] - $i[$_];
        ($min, @result) = ($diff) if $diff < $min;
        push @result, [ @i[ $_, $_+1 ] ] if $diff == $min;
    }
    @result;
}

use Test::More tests => 3;
is_deeply [ f(4, 1, 2, 3)      ], [ [1,2], [2,3], [3,4] ];
is_deeply [ f(1, 3, 7, 11, 15) ], [ [1,3]               ];
is_deeply [ f(1, 5, 3, 8)      ], [ [1,3], [3,5]        ];
