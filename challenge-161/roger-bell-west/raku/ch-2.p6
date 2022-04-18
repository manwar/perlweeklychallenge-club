#! /usr/bin/perl6

my %f;
my %r;

for lines() {
    .chomp;
    my $b = 1;
    my $v = 0;
    for 'a'..'z' -> $l {
        with index($_,$l) {
            $v +|= $b;
        }
        $b +<= 1;
    }
    if (%r{$v}:!exists || %r{$v}.chars > $_.chars) {
        %f{$_}=$v;
        %r{$v}=$_;
    }
}

my @w;
my $lt = (1 +< 26) -1;
my @lu = (0);
while (@lu[*-1] != $lt) {
    my $wn = '';
    if (@w.elems > 0) {
        my $mode = 0;
        my @sc;
        for %r.keys -> $wv {
            if (($wv +& @lu[*-1]) == 0) {
                if ($mode == 0) {
                    $mode = 1;
                    @sc = ();
                }
                @sc.push(%r{$wv});
            } elsif ($mode==0 && ($wv +| @lu[*-1]) != @lu[*-1]) {
                @sc.push(%r{$wv});
            }
        }
        if (@sc.elems == 0) {
            @w.pop;
            @lu.pop;
        } else {
            $wn = @sc.pick;
        }
    } else {
        $wn = %f.keys.pick;
    }
    if ($wn ne "") {
        @w.push($wn);
        @lu.push(@lu[*-1] +| %f{$wn});
    }
}

say @w.join(" ");
