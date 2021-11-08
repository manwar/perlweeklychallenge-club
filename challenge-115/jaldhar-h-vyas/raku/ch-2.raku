#!/usr/bin/raku

sub MAIN(*@args) {
    my @N = @args.sort({$^b <=> $^a});

    if @N[*-1] % 2 == 1 {
        my $lasteven = 1;
        while @N[*-$lasteven] !~~ Nil && @N[*-$lasteven] % 2 == 1 {
            $lasteven++;
        }

        if @N[*-$lasteven] !~~ Nil {
            my $temp = @N[*-$lasteven];
            @N.splice(*-$lasteven, 1);
            @N.push($temp);
        } else {
            @N[*-1]--;
        }
    }

    @N.join.say;
}