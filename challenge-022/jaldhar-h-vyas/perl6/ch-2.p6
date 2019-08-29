#!/usr/bin/perl6

sub init_dict {
    return (0 .. 255).map({ $_.chr => $_.chr});
}

sub uncompress(@data) {
    my @output;
    my %dict = init_dict();
    my $i = %dict.elems;
    my $l = 0;
    my $p = @data[$l];
    my $s = %dict{$p};
    my $c = $s.substr(0, 1);

    @output.push($s);

    while $l < @data.elems - 1 {
        my $n = @data[++$l];
        if %dict{$n}:!exists {
            $s = "%dict{$p}$c";
        } else {
            $s = %dict{$n};
        }
        @output.push($s);
        $c = $s.substr(0, 1);
        %dict{++$i} = "%dict{$p}$c";
        $p = $n;
    }

    return @output.join(q{});
}

sub compress(Str $data) {
    my @output;
    my %dict = init_dict();
    my $i = %dict.elems;
    my $l = 0;
    my $p = $data.substr($l, 1);

    while $l < $data.chars {
        my $c = $data.substr( ++$l, 1);
        if %dict{"$p$c"}:exists {
            $p = "$p$c";
        } else {
            @output.push(%dict{$p});
            %dict{"$p$c"} = ++$i;
            $p = $c;
        }
    }

    @output.push(%dict{$p});

    return @output;
}

my $phrase = 'TOBEORNOTTOBEORTOBEORNOT';
# There and back again...
say (($phrase eq uncompress(compress($phrase))) ?? 'OK' !! 'NOK');