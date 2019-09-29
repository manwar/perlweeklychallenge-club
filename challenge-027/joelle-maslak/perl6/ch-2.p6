#!/usr/bin/env perl6
use v6;

# Limitation: With nested data structures, we only store the version as
# it existed at the time of setting the proxy (I.E. an array that
# changes *after* the proxy variable is set will only be stored as the
# initial value of the array.
class History {
    has @!hist;
    has $!data;

    method get-proxy() is rw {
        my $data    := $!data;
        my $history := @!hist;
        Proxy.new(
            FETCH => method ()     { $data },
            STORE => method ($val) { $data = $val; $history.push( $data.clone ) },
        );
    }

    method history() {
        my @h = @!hist;
        @h.push: $!data;
        return @h;
    }
}

sub MAIN() {
    my $hist = History.new;
    my $x := $hist.get-proxy();

    $x  = 10;
    $x  = 20;
    $x -= 5;

    my $y := $hist.get-proxy();  # It's okay to have multiple proxies
    $y++;
    $y = 'Foo!';

    # And to show that the second proxy is using the same values
    $x ~= ' Bar!';

    # A new instance of history should be independnet.
    my $hist2 = History.new;
    my $z := $hist2.get-proxy();
    $z = 3;  # Won't show up in history for $hist.

    # And we just set the original history, the one we log, to a new
    # value
    $x = 'Baz.';

    # Also let's do an array.
    my @a = 1,2,3;
    $x = @a;

    say join("\n", $hist.history».perl);
}


