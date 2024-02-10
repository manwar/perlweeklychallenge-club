#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my %merges;

    for @args -> $arg {
        my @temp = $arg.words;
        my $name = @temp.shift;
        %merges{$name}.push(@temp);
    }

    for %merges.keys -> $key {
        for 0 ..^ %merges{$key}.elems - 1 -> $i {
            for $i ^..^ %merges{$key}.elems -> $j {
                if (%merges{$key}[$i] ∩ %merges{$key}[$j]).elems {
                    %merges{$key}[$i] = (%merges{$key}[$i] ∪ %merges{$key}[$j]).keys;
                    %merges{$key}[$j] = ();
                }
            }
        }
    }

    my @output;
    for %merges.keys -> $key {
        for %merges{$key}.values -> $value {
            if @$value.elems {
                @output.push(q{[} ~ [ $key, | @$value ].map({ q{"} ~ $_ ~ q{"} }).join(q{, }) ~ q{]});
            }
        }
    };

    say q{[ },  @output.sort({ @$^a cmp @$^b }).join(",\n"), q{ ]};
}
