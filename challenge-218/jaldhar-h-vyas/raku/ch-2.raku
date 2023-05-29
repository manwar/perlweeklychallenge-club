#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @matrix;
    for 0 .. @args.end -> $i {
        @matrix[$i].push(| @args[$i].split(/','/));
    }
    my $m = @matrix.elems;
    my $n = @matrix[0].elems;

    for (0 ..^ $m) -> $i {
        if @matrix[$i;0] eq '0' {
            for (0 ..^ $n) -> $j {
                @matrix[$i;$j] = (@matrix[$i;$j] eq '1' ?? '0' !! '1');
            }
        }
    }

    for (0 ..^ $n) -> $i {
        my %count = @matrix[0 ..^ $m;$i].classify({ $_; });
        if %count{0}.elems > %count{1}.elems {
            for (0 ..^ $m) -> $j {
                @matrix[$j;$i] = (@matrix[$j;$i] eq '1' ?? '0' !! '1');
            }
        }
    }

    @matrix.map({ '0b' ~ @$_.join(q{}) }).sum.say;
}