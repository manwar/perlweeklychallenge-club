#! /usr/bin/raku

use Test;

plan 3;

is(exactchange([5, 5, 5, 10, 20]), True, 'example 1');
is(exactchange([5, 5, 10, 10, 20]), False, 'example 2');
is(exactchange([5, 5, 5, 20]), True, 'example 3');

class Reserve {
    has @!values;
    has @!counts;
    has %!vm;

    method TWEAK(:@notes) {
        my @vq = @notes.sort({$^b <=> $^a});
        for (0..@vq.end) -> $i {
            %!vm{@vq[$i]} = $i;
        }
        @!values = @vq;
        @!counts = 0 xx @vq.elems;
    }

    method makechange($price, @tendered) {
        my $val = 0;
        for @tendered -> $note {
            unless (%!vm{$note}:exists) {
                return False;
            }
            @!counts[%!vm{$note}]++;
            $val += $note;
        }
        if ($val < $price) {
            return False;
        }
        $val -= $price;
        for 0..@!values.end -> $bid {
            while ($val >= @!values[$bid] && @!counts[$bid] > 0) {
                $val -= @!values[$bid];
                @!counts[$bid]--;
            }
        }
        return ($val == 0);
    }
}

sub exactchange(@a) {
    my $reserve = Reserve.new(notes => [5, 10, 20]);
    for @a -> $tendered {
        unless ($reserve.makechange(5, [$tendered])) {
            return False;
        }
    }
    return True;
}
