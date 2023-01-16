#!/usr/bin/raku

sub MAIN(
    *@list
) {
    @list = @list.sort({ $^a <=> $^b });
    my $mid = @list.elems div 2;
    my @sorted;
    my $odd = @list.elems % 2 == 1;

    if $odd {
        @sorted.push(@list[$mid]);
    }

    for 0 ..^ $mid -> $i {
        if $odd {
            @sorted.push(@list[@list.end - $i], @list[$i]);
        } else {
            @sorted.push(@list[$i], @list[@list.end - $i]);
        }
    }

    say q{(}, @sorted.join(q{,}), q{)};
}