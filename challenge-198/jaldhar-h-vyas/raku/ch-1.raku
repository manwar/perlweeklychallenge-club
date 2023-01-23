#!/usr/bin/raku

sub MAIN(*@args) {
    my @list = @args.sort({$^a <=> $^b});

    if @list.elems < 2 {
        say 0;
    } else {
        my %gaps;

        for 1 .. @list.end -> $i {
            %gaps{(@list[$i] - @list[$i - 1])}.push([@list[$i - 1], @list[$i]]);
        }

        %gaps.sort({ $^b.value.elems <=> $^a.value.elems }).first.value.elems.say;
    }
}