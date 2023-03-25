#!/bin/env raku

sub USAGE() {
    print qq:to/END/;
    examples:
        $*PROGRAM-NAME emails01.txt
        $*PROGRAM-NAME emails02.txt
    END
}

unit sub MAIN(Str:D $f where *.IO.e);

my @email-data = $f.IO.lines.map({ .words.Array });

my %email-sets;
for @email-data -> $list {
    my $name    = $list.head;
    my $new-set = $list.tail(*-1).Set;

    my Bool $joined = False;
    for ^%email-sets{$name}.elems -> $i {
        if $new-set (&) %email-sets{$name}[$i] > 0 {
            %email-sets{$name}[$i] (|)= $new-set;
            $joined = True;
            last;
        }

        LAST { %email-sets{$name}.push($new-set) unless $joined; }
    }
}

for %email-sets.keys -> $name {
    for %email-sets{$name}.Array -> $list {
        put $name, ', ', $list.keys.join(', ');
    }
}
