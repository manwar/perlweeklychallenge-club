#!/usr/bin/raku

sub MAIN(
    $items1,
    $items2
) {
    my %merged;
    for "$items1 $items2".split(/\s+/).map({ $_.split(/\,/) }) -> $item {
        %merged{@$item[0]} += @$item[1];
    }

    say q{[ }, 
        %merged
            .sort
            .map({ "[{$_.key},{$_.value}]" })
            .join(q{, }),
    q{ ]};
}