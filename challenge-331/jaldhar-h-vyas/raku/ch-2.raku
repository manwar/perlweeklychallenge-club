#!/usr/bin/raku

sub isBuddyString($source, $target) {
    if $source.chars != $target.chars {
        return False;
    }

    if ($source eq $target) {
        my %count;

        for $source.comb -> $c {
            %count{$c}++;
        }

        return %count.values.grep({ $_ > 1 }).so;
    }

    my $diff;
 
    for 0 ..^ $source.chars -> $i {
        if $source.substr( $i, 1) ne $target.substr($i, 1) {
            $diff++;
        }
    }

    if $diff != 2 {
        return False;
    }

    return True;
}

sub MAIN(
    $source,
    $target
) {
    isBuddyString($source, $target).say;
}