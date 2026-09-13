#!/usr/bin/raku

sub MAIN(
    $str
) {
    my @counts;
    my @parts = [q{}];
    my $count = q{};

    for $str.comb -> $c {
        given $c {
            when /\d/ {
                $count ~= $c;
            }

            when q{[} {
                @counts.push($count);
                @parts.push(q{});
                $count = q{};
            }

            when q{]} {
                my $part = @parts.pop;
                my $repeat = @counts.pop;
                @parts[*-1] ~= $part x $repeat;
            }

            default {
                @parts[*-1] ~= $c;
            }
        }
    }

    say @parts[0];
}
