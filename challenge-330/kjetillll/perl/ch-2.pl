sub f {
    lc(pop) =~ s/\w{3,}/\u$&/gr
}
print f( $$_[0] ) eq $$_[1] ? "ok\n" : "err $s\n" for map [ split/\s*->\s*/ ], split /\n/, <<'';
PERL IS gREAT        -> Perl is Great
THE weekly challenge -> The Weekly Challenge
YoU ARE A stAR       -> You Are a Star
