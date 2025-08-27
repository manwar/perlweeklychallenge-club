#!/usr/bin/raku

sub MAIN(
    *@scores
) {
    my @previous; 

    for @scores -> $score {
        given $score {
            when 'C' {
                @previous.pop;
             }
            when 'D' {
                @previous.push(2 * @previous[*-1]);
            }
            when '+' {
                @previous.push(@previous[*-1] + @previous[*-2]);

            }
            default {
                @previous.push($score);
            }
        } 
    }

    say @previous.sum;
}