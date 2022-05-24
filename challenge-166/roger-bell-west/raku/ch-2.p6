#! /usr/bin/perl6

sub kdd(@dirlist0) {
    my @dirlist = @dirlist0.sort();
    my %fx;
    for @dirlist -> $d {
        for dir($d) -> $entry {
            my $nn = $entry;
            $nn ~~ s/.*\///;
            if ($entry.d()) {
                $nn ~= '/';
            }
            %fx{$nn} ||= SetHash.new();
            %fx{$nn}{$d}++;
        }
    }
    my $mm=@dirlist.elems();
    my @out=[@dirlist,];
    for %fx.keys().sort() -> $f {
        unless (%fx{$f}.elems() == $mm) {
            my @l;
            for @dirlist -> $d {
                if (%fx{$f}{$d}:exists) {
                    @l.push($f);
                } else {
                    @l.push('');
                }
            }
            @out.push(@l);
        }
    }
    return @out;
}

sub tabular(@d) {
    my @columnlength;
    for @d -> @row {
        for (0..@row.elems-1) -> $i {
            while (@columnlength.elems() <= $i) {
                @columnlength.push(0);
            }
            @columnlength[$i]=max(@columnlength[$i],@row[$i].chars());
        }
    }
    my $format=@columnlength.map({'%-' ~ $_ ~ 's'}).join(' | ') ~ "\n";
    for @d -> @row {
        $format.printf(@row);
    }
}

tabular(kdd(["dir_a","dir_b","dir_c"]));
