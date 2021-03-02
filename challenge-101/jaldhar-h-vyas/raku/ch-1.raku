#!/usr/bin/raku

sub factors(Int $size) {

    my @tightest = ($size, 1);
    my $minimum =  abs(@tightest[0] - @tightest[1]);

    for (2 .. $size div 2).grep({ $size %% $_ }) -> $m {
        my $n = $size div $m;
        my $difference = abs($m - $n);
        if ($difference < $minimum) {
            $minimum = $difference;
            @tightest = ($m, $n);
        }
    }

    return @tightest;
}

sub spiral(Int $m, Int $n, *@a) {
    my $top = 0;
    my $bottom = $m - 1;
    my $left = 0;
    my $right = $n - 1;
    my $index = 0;
    my @matrix;

    loop {
        if ($left > $right) {
            last;
        }

        for $left .. $right -> $i {
            @matrix[$bottom][$i] = @a[$index++];
        }
        $bottom--;
 
        if ($top > $bottom) {
            last;
        }

        for ($top .. $bottom).reverse -> $i {
            @matrix[$i][$right] = @a[$index++];
        }
        $right--;
 
        if ($left > $right) {
            last;
        }

        for ($left .. $right).reverse -> $i {
            @matrix[$top][$i] = @a[$index++];
        }
        $top++;
 
        if ($top > $bottom) {
            last;
        }

        for $top .. $bottom -> $i {
            @matrix[$i][$left] = @a[$index++];
        }
        $left++;
    }

    for 0 .. @matrix.elems - 1 -> $i {
        for 0 .. @matrix[$i].elems - 1 -> $j {
            printf '%2d ', @matrix[$i][$j];
        }
        print "\n";
    }
}

sub MAIN(
    *@A
) {
    my @tightest = factors(@A.elems);

    spiral(@tightest[0], @tightest[1], @A);
}