#!/usr/var/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

=begin spec
￼
185 Task 2: Mask Code       Submitted by: Mohammad S Anwar
Given a list of codes in any random format, mask first four
a-z-or-0-9 characters.

Example 1
Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')
=end spec

my regex significant { <:Ll> | <:Nd> }

# Added A-Z to the mask-able char set
sub mask( Str $s, Str :$mask='x', Int :$ct is copy = 4 --> Str ) {
    my @a = $s.comb;
    my $i = 0;
    for 0 .. @a.end -> $i {
        if @a[$i] ~~ / <significant> / {
            @a[$i] = $mask;
            --$ct;
            last unless $ct;
        }
    }
    @a.join
}

my @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy',
                '1234567.a', 'a-1234-bc', 'a.b.c.d.e.f',
                'a_bcde_f', 'a bc e f', '(abc) def',
                'a.b.c' );
my @exp  = ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy',
                'xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f',
                'x_xxxe_f', 'x xx x f', '(xxx) xef',
                'x.x.x');

my @got = @list.map: { mask $_ };

die unless @got eqv @exp;

say "Input: \@list = ", @list.raku;
say "Output:         ", @got.raku;

