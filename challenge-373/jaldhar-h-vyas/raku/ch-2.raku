#!/usr/bin/raku

sub MAIN(
    $n,
    *@list
) {
    if @list.elems < $n {
        say "-1";
    } else {
        my $len = @list.elems div $n;
        my $rem = @list.elems % $n;

        my @groups = $len xx $n;
        my $i = 0;
        while $rem != 0 {
            @groups[$i++] += 1;
            $rem--;
        } 

        my @results = @groups.map({ @list.splice(0, $_) });

        say q{(},
            @results.map({ q{(} ~ @$_.join(q{,}) ~ q{)} }).join(q{, }),
        q{)};   
    }
}
