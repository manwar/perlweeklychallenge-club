#!/usr/bin/raku


sub MAIN(
    *@args
) {
    my @list1 = @args.shift.words;
    my @list2 = @args.shift.words;
    my @list3 = @args.map({ .words.List });
    my $result = True;

    if @list1.elems != @list2.elems {
        $result = False;
    } else {
        for @list1.keys -> $i {
            if @list1[$i] eq @list2[$i] {
                @list1[$i]:delete;
                @list2[$i]:delete;
            }
        }

        for @list1.keys -> $i {
            my $similar = @list3[$i];
            if @list1[$i] ∉ @$similar || @list2[$i] ∉ @$similar {
                $result = False;
                last;
            }
        }
    }

    say $result;
}
