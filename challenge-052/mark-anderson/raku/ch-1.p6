#!/usr/bin/env raku

my @results;

sub MAIN($arg1, $arg2 where $arg1 >= 100 < $arg2 <= 999) {
    my $start = $arg1.polymod(10,10).Array.pop;
    my $stop  = $arg2.polymod(10,10).Array.pop;
  
    for $start .. $stop -> $num {
        step_it($arg1, $arg2, $num);
        say @results.join("\n") if @results;
    }
}

sub step_it($arg1, $arg2, $num) {
    @results = Empty;
    @results.push($num);

    while @results {
        last if @results[0].chars == $arg2.chars;
        my $num = @results.shift;
        my $last_digit = $num % 10;

        unless $last_digit == 0 {
            my $new = $num ~ $last_digit - 1;
            push_it($arg1, $arg2, $new);
        }

        unless $last_digit == 9 {
            my $new = $num ~ $last_digit + 1;
            push_it($arg1, $arg2, $new);
        }
    }
}

sub push_it($arg1, $arg2, $new) { 
    if $new >= $arg1.substr(0, $new.chars) {
        if $new <= $arg2.substr(0, $new.chars) {
            @results.push($new);
        }
    }
}
