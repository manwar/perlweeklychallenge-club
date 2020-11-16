#!/usr/bin/env raku

# test with:
# raku ch-2.raku --debug=False  # otherwise it will show debug output as well.
# example is built-in this case for (maybe) easier review

# note: this is a non-recursive implementaion
#       entry point is localted in MAIN()

our $d is export;

class row-candidates {
    has ( Hash $!cnd, Int $!r );        # candidates, row number
    has Set ( $!nar, @!nac, @!naa );    # N/A(na) number in (r)ow, (c)olumn,
                                        # and (a)rea
    has Array ( $.base,                 # base  for all rows
                $!drf,                  # draft for current row only
                $!slt,                  # slots (where we need to fill up)
                $!cur, );               # current values in slots

    submethod BUILD (:$r, :$base where { 0 <= $r < 9 }) {
        $!r = $r;
        if $d {
            say "base matrix for row[$r]:";
            .say for $base.Array
        }

        $!base = $base.clone;           # copy whole matrix.
        my \ro = $!base[$!r]>>.Str;     # : orginally IntStr,
                                        # which makes Set or SetHash compare
                                        # with Set of Int
                                        # please also refer NOTE1.
                                        # IntStr is sometimes very annoying :(

        my $rgr = do given $!r div 3 { 3* $_ ..^ 3* $_.succ };  # rows in the
                                                                # same area

        # generate unavailable number for row, column*s* area*s*)
        $!nar = ro.Set;
        for ^9 { @!nac[$_] = $!base[*;$_]>>.Str.Set }
        for ^3 {
            my $rgc = (3* $_) ..^ (3* $_.succ);
            @!naa[$_] = $!base[$rgr[*];$rgc[*]]>>.Str.Set;      # [*] is must!!!
            #@!naa[$_].raku.say;
        }
        # copy draft from base
        $!drf = ro.clone.Array;
        $!slt = $!drf.grep({$_ eq '_'}, :k).Array;      # register slots as idx
        $!cur = (Nil xx $!slt).Array;                   # prepare spaces

        # and fill up the slots with available numbers for the first time
        self.fill-slots;
    }

    method fill-slots {
        # NOTE1 $!nar stored as .Str so (1..9) must be all .Str
        my $avn = (('1'..'9') ∖ $!nar).SetHash; # available numbers in row
        my $avn0 = $avn; # backup

        # find the the column number where we start to fill up
        # (where no current value is set at rightmost) or // zero
        loop ( my $si = ($!cur.first({.defined}, :end, :k) andthen .succ) // 0;
               $si < $!slt.elems; ) {
            my $c = $!slt[$si];
            my $an = $c div 3; # area number ( 0 | 1 | 2 )
            my $avn1 = ( [∖] $avn,              # (+) available numbers in row
                         $!cur.grep({.defined}),# (-) remove number used one
                         @!naa[$an],            # (-) numbers used in area
                         @!nac[$c],             # (-) numbers used in column
                       ).SetHash;
            if $d {
                say "[$!r;$c] si: $si, c: $c; area num: $an";
                say "[$!r:$c] avn: $avn, naa: @!naa[$an], nac: @!nac[$c]";
                say "[$!r;$c]:{self.snapshot(:force)}: "~
                "cur => {$!cur.map({.defined??$_!!'?'})} avn' => $avn1";
            }

            if $avn1.elems.so {
                my $n = $avn1.grab(1);          # note: returned as Seq
                $!cur[$si] = $n[0];             # -> so take first elem
                $!cnd{$c} = $avn1.clone         # update candidates
                          if $avn1.elems.so;
                $avn ∖=  $n;                    # reduce avaiable num
                ++$si;
            }
            else {
                my $i;
                if $!cnd andthen .elems.not     # no more candis: failed
                    or ( $i = self!forward_ )
                       !~~ any(Str,Int) {       # forward_ will return index
                                                # or Nil when failed to forward_
                    Nil.return;
                }

                $si = 1 + $i;
                # reset available numbers
                $avn = $avn0;
            }
        }
        if $d {
            say "[$!r] all filled up:";
            say self.snapshot;
            if $!cnd andthen .elems.so {
                say "... still have candiates: {$!cnd.raku}";
            }
            else {
                say "... but this is last case of row $!r";
            }
        }
        True # succeed to fill up
    }

    method snapshot (Bool :$force = False) {
        my $dup = $!drf.clone;
        if $force.not and
           $!cur.grep({.defined}).elems != $!slt.elems {
            Nil.return;
        }
        else {
            $dup[|$!slt] = $!cur.map({$_//'?'}).Array;
        }
        $dup
    }

    # forward_: try to set up next possible case
    method !forward_ {

        # find the slot has candidates at rightmost
        with $!cnd andthen .sort.tail {
            # .key: column num; .value: candidates(SetHash)
            my $n = .value.grab(1);                     # grab a candidate
            my $i = $!slt.first(.key, :k);
            my $o = $!cur[$i];
            $!cur[$i] = $n[0];                          # put into current value
            $!cur[$i.succ ..*] = Nil,Nil...*;           # undefine values
            $!cnd{.key}:delete if .value.elems.not;     # remove empty info
            say "[$!r;{.key}] change $o to $n"~
            " and rest candidates: {$!cnd.raku}" if $d;

            $i.return                                   # return changed index
                                                        # in $!cur
        }
        Nil
    }

    method forward {
        self!forward_
        andthen {
            self.fill-slots.
            return  # repect the return value from fill-slots()
        }
        Nil
    }
}

sub MAIN ( Bool :$debug = True ) {
    $d = $debug;
    my @s =
    #0 1 2 3 4 5 6 7 8
    <_ _ _ 2 6 _ 7 _ 1>,
    <6 8 _ _ 7 _ _ 9 _>,
    <1 9 _ _ _ 4 5 _ _>,
    <8 2 _ 1 _ _ _ 4 _>,
    <_ _ 4 6 _ 2 9 _ _>,
    <_ 5 _ _ _ 3 _ 2 8>,
    <_ _ 9 3 _ _ _ 7 4>,
    <_ 4 _ _ 5 _ _ 3 6>,
    <7 _ 3 _ 1 8 _ _ _>;

    my Int $r;
    my @canvas = @s.Array; # .Array also kind of clone
    my @rc;

    #################
    ## entry point ##
    #################
    loop ( $r = 0; 0 <= $r < 9; ) {
        # note: $r can be increased or decreased
        if @rc[$r].defined {
            # already exists: we get here when lower case is failed
            # so try next case at $r
            @rc[$r].forward orelse {
                # go higher if failed
                @rc[$r] = Nil;  # remove all row candiates
                @canvas = (@rc[--$r] andthen .base.Array) // @s.Array;
                next;
            }
        }
        else {
            @rc[$r] = row-candidates.new( :$r,
                                          :base(@canvas.clone));
        }

        if my $snp = @rc[$r].snapshot { # possible so far
            @canvas[$r] = $snp;
            ++$r;                       # going next row
        }
        else {
            # there is no more alternative case for current row
            # go higher row and try next candidate if any
            @rc[$r] = Nil;
            @canvas = ( @rc[--$r] andthen .base
                                  orelse    Nil );  # when $r < 0
        }
    }
    if $r < 9 {
        say "Not Possible";
        exit 1;
    }

    say "all good:" if $d;
    .say for @canvas;
}
