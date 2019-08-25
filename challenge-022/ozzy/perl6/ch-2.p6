#!/usr/bin/env perl6
# Script to implement Lempel–Ziv–Welch (LZW) compression algorithm, incl. encode/decode subs.
#
# Example: ch-2.p6 yadayada
# OUTPUT:
#
# Encoding
# String      : yadayada
# Code points : [121 97 100 97 121 97 100 97]
#
#     Output       Code      New dict. entry
#          y        121            ya  [256]
#          a         97            ad  [257]
#          d        100            da  [258]
#          a         97            ay  [259]
#         ya        256           yad  [260]
#         da        258
#
# Decoding
# Code points : [121 97 100 97 256 258]
#
#     Output       Code      New dict. entry
#          y        121
#          a         97             ya [256]
#          d        100             ad [257]
#          a         97             da [258]
#         ya        256             ay [259]
#         da        258            yad [260]
#
# Output: yadayada
# Success!

sub encode_buf (@ibuf) {

    say "Encoding";
    say "String      : ", map({.chr},@ibuf).join;
    say "Code points : ", @ibuf;
    printf "\n%10s %10s %20s\n", "Output", "Code", "New dict. entry";

    my %etable      = map { .chr => .Int }, ^256;
    my $ibuf_pos    = 0;
    my $C           = @ibuf[$ibuf_pos].chr;
    my $N;
    my @obuf;

    while $ibuf_pos < @ibuf.elems-1 {
        $N = @ibuf[++$ibuf_pos].chr;
        if %etable{ $C~$N } {
            $C~=$N;
        } else {
            %etable{ $C~$N } = %etable.values.elems;
            @obuf.push: %etable{$C};
            printf "%10s %10s %20s\n", $C, %etable{$C}, "$C$N  [{%etable{$C~$N}}]";
            $C=$N;
        }
    }
    @obuf.push: %etable{$C};
    printf "%10s %10s\n\n", $C, %etable{$C};
    return @obuf;
}



sub decode_buf (@ibuf) {

    say "Decoding";
    say "Code points : ", @ibuf;
    printf "\n%10s %10s %20s\n", "Output", "Code", "New dict. entry";

    my %dtable      = map { .Int => .chr }, ^256;
    my $ibuf_pos    = 0;
    my $C;
    my $N;
    my $S;
    my @obuf;

    my $P = @ibuf[$ibuf_pos];
    @obuf.push: %dtable{$P};
    printf "%10s %10s\n", %dtable{$P}, $P;

    while $ibuf_pos < @ibuf.elems-1 {
        $N = @ibuf[++$ibuf_pos];
        if ! %dtable{$N} {
            $S = %dtable{$P} ~ %dtable{$P}.substr(0,1);
            printf "%10s %10s %20s\n", $S, $N, "$S [$N]";
        } else {
            $S = %dtable{$N};
            printf "%10s %10s %20s\n", $S, $N, "{ %dtable{$P} ~ $S.substr(0,1) } [{ %dtable.elems }]";
        }
        @obuf.push: $S;
        %dtable{ %dtable.elems } = %dtable{$P} ~ $S.substr(0,1);
        $P = $N;
    }
    return @obuf;
}



sub MAIN ( Str $ascii_string = "Even if they are djinns, I will get djinns that can outdjinn them." ) {

    die "Invalid string" if $ascii_string !~~ rx:i/^ <[a..z]+[\s\!\"\#\$\%\&\'\(\)\*\+\,\-\.]>* $/;

    my @ibuf    = map({ .ord }, $ascii_string.comb);
    my @lzw_buf = encode_buf @ibuf;
    my @obuf    = decode_buf @lzw_buf;

    say "\nOutput: ", @obuf.join;
    say @obuf.join eq $ascii_string ?? "Success!" !! "Failure!";

}