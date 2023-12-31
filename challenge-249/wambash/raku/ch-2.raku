#!/usr/bin/env raku

sub DI-string-match ($s) {
    my @si = $s.comb;
    my @perm = 0 .. @si.elems;

    my @b = @si.map: { $_ eq 'I' ?? @perm.shift !! @perm.pop  }
    |@b, @perm.shift
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply DI-string-match('IDID'), (0,4,1,3,2);
    is-deeply DI-string-match('III'), (0,1,2,3);
    is-deeply DI-string-match('DDI'), (3,2,0,1);
    done-testing;
}

multi MAIN ($s) {
    say DI-string-match $s
}
