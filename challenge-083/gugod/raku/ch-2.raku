#!/usr/bin/env raku

sub choices (@n, $k) {
    return Seq.new(
        class :: does Iterator {
            has @!c = [0..$k-1];
            has $!end = False;
            method pull-one {
                if $!end { return IterationEnd }

                my @ret = @n[ @!c ];

                if @!c[0] == @n.elems - $k {
                    $!end = True;
                    return @ret;
                }

                my $i = 1;
                while @!c[$k-$i] == @n.elems - $i { $i++ }

                @!c[$k-$i]++;
                $i--;
                while $i > 0 {
                    @!c[$k-$i] = @!c[$k-$i-1] + 1;
                    $i--;
                }

                return @ret;
            }
        }.new()
    )
}

sub flip-elems (@n) {
    my $sum = [+] @n;
    my @min_choice;
    my $min_sum = Inf;
    my $min_k   = 0;
    for 1..@n.elems - 1 -> $k {
        for choices(@n, $k) -> @c {
            my $s = $sum - 2 * ([+] @c);
            if $s == 0 {
                @min_choice = @c;
                say ">> $s = ([+] {@n}) - 2 * ([+] {@min_choice})";
                return $k;
            }
            if 0 < $s < $min_sum {
                @min_choice = @c;
                $min_sum = $s;
                $min_k   = $k;
            }
        }
    }
    say ">> $min_sum = ([+] {@n}) - 2 * ([+] {@min_choice})";
    return $min_k;
}

# say flip-elems [2,13,10,8]; # 2
# say flip-elems [12,2,10]; # 1

say flip-elems @*ARGS;
