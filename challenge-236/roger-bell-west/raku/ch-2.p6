#! /usr/bin/raku

use Test;

plan 3;

is(arrayloops([4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10]), 3, 'example 1');
is(arrayloops([0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19]), 6, 'example 2');
is(arrayloops([9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17]), 1, 'example 3');

sub arrayloops(@a) {
    my $loop_id = 0;
    my %loops;
    for 0..@a.end -> $origin {
        unless %loops{$origin}:exists {
            my $li = 0;
            my $thisloop = SetHash.new;
            my $x = $origin;
            while True {
                if $x < 0 || $x > @a.end {
                    last;
                }
                $thisloop{$x} = True;
                $x = @a[$x];
                if %loops{$x}:exists {
                    $li = %loops{$x};
                    last;
                }
                if $thisloop{$x}:exists {
                    $loop_id++;
                    $li = $loop_id;
                    last;
                }
            }
            for $thisloop.keys -> $i {
                %loops{$i} = $li;
            }
        }
    }
    return $loop_id;
}
