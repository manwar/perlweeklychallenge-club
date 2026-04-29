#!/usr/bin/env raku

use Test;

my @examples = (
    { in  => <a c ? g i>, out => "e" },
    { in  => <a d ? j m>, out => "g" },
    { in  => <a e ? m q>, out => "i" },
    { in  => <a c f ? k>, out => "h" },
    { in  => <b e g ? l>, out => "j" },
);

for @examples -> %ex {
    is missing-character(|%ex<in>), %ex<out>;
}

done-testing;

sub missing-character(*@seq) {
    my @nums = @seq.map: { $_ eq '?' ?? Nil !! $_.ord - 'a'.ord + 1 };

    my ($x, $y);

    # 2. Identify steps
    for 0..3 -> $i {
        if @nums[$i].defined && @nums[$i + 1].defined {
            my $diff = @nums[$i + 1] - @nums[$i];
            ($i % 2 == 0) ?? ($x = $diff) !! ($y = $diff);
        }
    }

    # 3. Handle missing x or y logic
    if !$x.defined || !$y.defined {
        for 0..2 -> $i {
            if @nums[$i].defined && @nums[$i + 2].defined {
                my $total = @nums[$i + 2] - @nums[$i];
                if $x.defined {
                    $y = $total - $x;
                }
                elsif $y.defined {
                    $x = $total - $y;
                }
                else {
                    $x = $y = $total / 2;
                }
            }
        }
        $x //= $y;
        $y //= $x;
    }

    # 4. Find the '?' index and fill it
    my $idx = @nums.first(!*.defined, :k);

    if $idx == 0 {
        @nums[0] = @nums[1] - $x;
    } else {
        my $step = ($idx - 1) % 2 == 0 ?? $x !! $y;
        @nums[$idx] = @nums[$idx - 1] + $step;
    }

    return (@nums[$idx] + 'a'.ord - 1).chr;
}
