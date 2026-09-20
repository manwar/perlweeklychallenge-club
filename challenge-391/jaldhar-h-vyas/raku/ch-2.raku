#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @boxes = @args.map({ [ $_.words ] });
    @boxes = @boxes.sort({ $^a[0] <=> $^b[0] || $^b[1] <=> $^a[1] });

    my @longest = @boxes.map({ 1 });
    for @boxes.keys -> $i {
        for 0 ..^ $i -> $j {
            if @boxes[$j][0] < @boxes[$i][0] && @boxes[$j][1] < @boxes[$i][1] {
                @longest[$i] = max(@longest[$i], @longest[$j] + 1);
            }
        }
    }

    say @longest.max;
}
