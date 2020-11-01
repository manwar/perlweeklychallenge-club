our $d is export = False; # `export' is needed to use globaly

sub rev-int ( Int $n --> Str ) {
    ("","-")[+($n < 0)] ~ $n.abs.flip
}

# return absoulte value of limitation in 32 bit (without sign)
# with check sign of $n
sub abslim (Str $n, $bit = 32) {
    (1 +< $bit.pred)-($n.substr(^1) ne "-")
}
sub filter32bit( Str $nstr ) {
    # assume this is 32bit machine
    # so this routine will get a reversed string (with sign prepended)
    # and compare it with limit value as strings

    my $lstr = abslim($nstr).Str;
    my $nstr-abs = S/^0+//   # remove zeroes in the beginging. for better cmp.
                   with $nstr.subst("-","");       # disgard the sign as well.
        say "[FLTR] ",($nstr-abs gt $nstr ?? "-" !! ""),$lstr if $d;
        $nstr-abs eq "" and 0.return;  # when get zero(es) as input

        # better read bottom up
        ($nstr.Int but "0",
         $nstr.Int)[
            ( Less => True,
              Same => $nstr-abs lt $lstr,
              More => False,
            ).Hash.{$nstr-abs.chars <=> $lstr.chars} ]
}

sub dmsg-tap (Any $a) { say("[DBG",$++,"] $a"); $a;};

multi MAIN (Int:D \N, Bool:D :$v = False) {
    # side effect?: when use multi with MAIN (even though has a MAIN declared),
    #               raku gives a simple help message with invalid args.

    my @solution-chain = &filter32bit, &rev-int;
    my @speaker = ($v
                  ?? |(&dmsg-tap) xx @solution-chain.elems # say each step
                  !! &say);                                 # or just result
    my @app-chain = (roundrobin @speaker, @solution-chain).flat;

    if $v {
        $d = True;
        "the chain of subroutines looks like ...".say;
        for (reverse @app-chain).kv -> $i, $r {
            say "$i: {$r.raku}";
        }
        "and answer is ...\n".say;
    }

    ([∘] @app-chain)(N);
    # or we can save it as a variable and execute.
    # but it was skipped as single usage.
    # i.e.
    # my $app = [∘] @app-chain;
    # $app(N);
}
