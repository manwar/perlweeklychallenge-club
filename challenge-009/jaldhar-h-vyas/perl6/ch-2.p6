#!/usr/bin/perl6

sub group(@items) {
    my %groups;
    my $rank = 1;
    my $current = @items[0];

    for @items -> $item {
        if $item !~~ $current {
            $rank++;
            $current = $item;
        }
        %groups{$rank}.push($item);
    }

    return %groups;
}

sub denseRank(%groups) {
    my @results;
    for %groups.keys.sort -> $rank {
        for %groups{$rank}.list -> $item {
            @results.push(Pair.new($rank, $item));
        }
    }

    return @results;
}

sub modifiedRank(%groups) {
    my @results;
    my $total = 0;
    for %groups.keys.sort -> $rank {
        $total += %groups{$rank}.elems;
        for %groups{$rank}.list -> $item {
            @results.push(Pair.new($total, $item ));
        }
    }

    return @results;
}

sub standardRank(%groups) {
    my @results;
    my $total = 1;
    for %groups.keys.sort -> $rank {
        for %groups{$rank}.list -> $item {
            @results.push(Pair.new($total, $item ));
        }
        $total += %groups{$rank}.elems;
    }

    return @results;
}

sub display(@results) {
    for @results -> Pair $result {
        say $result.key, ' -> ', $result.value;
    }
}

multi sub MAIN (
    *@items,            #= a list of items to rank
    Bool :$d! where .so #= dense ranking
) {
    @items.sort ==> group() ==> denseRank() ==> display();
}

multi sub MAIN (
    *@items,
    Bool :$m! where .so #= modified ranking
) {
    @items.sort ==> group() ==> modifiedRank() ==> display();
}

multi sub MAIN (
    *@items,
    Bool :$s! where .so #= standard ranking
) {
    @items.sort ==> group() ==> standardRank() ==> display();
}
