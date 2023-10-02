#!/usr/bin/env -S perl -wl

#-- perl 4 syntax

print join ',', &duplicate_zeros(1,0,2,3,0,4,5,0);#1,0,0,2,3,0,0,4
print join ',', &duplicate_zeros(1,2,3);#1,2,3
print join ',', &duplicate_zeros(0,3,0,4,5);#0,0,3,0,0

sub duplicate_zeros {
    local $duplicate_zeros = $#_;
    local @duplicate_zeros = ();
    foreach (0 .. $#_){($_[$_]==0) && (push @duplicate_zeros,$_) }

    foreach (0 .. $#duplicate_zeros) {
        ($_ > $duplicate_zeros) && (last);
        splice(@_,$duplicate_zeros[$_],0,0);
        foreach ($_ .. $#duplicate_zeros) {
            $duplicate_zeros[$_]++;
        }
    }
    @_[0 .. $duplicate_zeros];
}

