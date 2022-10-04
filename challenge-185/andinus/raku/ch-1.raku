unit sub MAIN(
    Str $mac-address, #= MAC address (hhhh.hhhh.hhhh)
);

# Converts in hh:hh:hh:hh:hh:hh form.
for $mac-address.comb(/\w/) {
    .print;
    given $++ {
        when 11 { succeed; }
        when $_ !%% 2 { print ":" }
    }
}
