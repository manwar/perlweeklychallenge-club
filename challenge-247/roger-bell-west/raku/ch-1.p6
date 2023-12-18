#! /usr/bin/raku

use Test;

plan 2;

is(secretsanta(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross']), True, 'example 1');
is(secretsanta(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar']), True, 'example 2');

sub secretsanta(@name) {
    my @family;
    for @name -> $n {
        push @family, comb(/\w+/, $n)[*-1];
    }
    my %receivers = SetHash(0 .. @name.end);
    my @gifting;
    for (0 .. @name.end) -> $giver {
        my $done = False;
        my $r = 0;
        for %receivers.keys -> $recipient {
            if (@family[$giver] ne @family[$recipient]) {
                $r = $recipient;
                $done = True;
                last;
            }
        }
        if (!$done) {
            for %receivers.keys -> $recipient {
                if ($recipient != $giver) {
                    $r = $recipient;
                    last;
                }
            }
        }
        %receivers{$r}:delete;
        push @gifting, [@name[$giver], @name[$r]];
    }
    for @gifting -> @p {
        say("@p[0] -> @p[1]");
    }
    say "";
    return True;
}
