#!/usr/bin/raku

sub MAIN(
    $r,
    $c,
    *@args
) {
    my @input = @args.map({ $_.split(/\s/).map({ $_.Int; }); }).flat;

    if $r * $c > @input.elems {
        say 0;
        exit;
    }

    my @output;

    for 0 ..^ $r {
        my @temp;
        for 0 ..^ $c {
            @temp.push(@input.shift);
        }
        @output.push(@temp);
    }

    if (@output.elems > 1) {
        print '[ ';
    }

    @output.map({ '[ ' ~ @$_.join(q{, }) ~ ' ]' }).join(q{, }).print;

    if (@output.elems > 1) {
        print ' ]';
    }

    print "\n";
}