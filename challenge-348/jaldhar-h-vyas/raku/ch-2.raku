#!/usr/bin/raku

sub MAIN(
    $source,
    $target
) {
    my ($sourceHours, $sourceMinutes) = $source.split(':');
    my ($targetHours, $targetMinutes) = $target.split(':');

    if $targetHours < $sourceHours {
        $targetHours += 24;
    }

    my $diff = ($targetHours * 60 + $targetMinutes) -
        ($sourceHours * 60 + $sourceMinutes);
    my @ops = 60, 15, 5, 1;
    my $count = 0;

    for @ops -> $op {
         while $diff >= $op {
            $diff -= $op;
            $count++;
        }
    }

    say $count;
}