#!/usr/bin/raku

sub MAIN(
    *@routes
) {
    my %timetable;

    for @routes -> $route {
        my ($freq, $start, $time) = $route.words;
        my $departure = $start;
        while $departure < 60 {
            %timetable{$departure} = $departure + $time;
            $departure += $freq;
        }
    }

    my @starts = %timetable.keys.sort({ $^a <=> $^b });
    my @output;

    for 0 .. 59 -> $minute {
        my $next = 0;
        for @starts.keys -> $s {
            if @starts[$s] >= $minute {
                $next = $s;
                last;
            } 
        }
        my $later =  $next == @starts.end 
            ?? %timetable{@starts[0]} + 60
            !! %timetable{@starts[$next + 1]};

        if %timetable{@starts[$next]} > $later {
            @output.push($minute);
        }
    }

    say q{[}, @output.join(q{, }), q{]};
}
