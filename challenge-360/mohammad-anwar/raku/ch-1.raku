#!/usr/bin/env raku

use Test;

my %examples = (
    4   => "3,1"   ,
    12  => "8,3,1" ,
    20  => "13,5,2",
    96  => "89,5,2",
    100 => "89,8,3",
);

sub zeckendorf($n is copy) {
    my @f = (1, 2);

    push @f, @f[*-1] + @f[*-2] while @f[*-1] <= $n;
    @f.pop;
    my @r;
    loop (my $i = @f.end; $i >= 0; $i--) {
        if @f[$i] <= $n {
            push @r, @f[$i];
            $n -= @f[$i];
        }
    }

    return @r.join(",");
}

for %examples.keys -> $key {
    is zeckendorf($key), %examples{$key};
}

done-testing;
