#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment

Task 185-1: MAC Address         Submitted by: Mohammad S Anwar
Given a MAC address in the form i.e. hhhh.hhhh.hhhh.

Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.

Example 1
Input:  1ac2.34f0.b1c2
Output:  1a:c2:34:f0:b1:c2

=end comment

my regex hex-char    {  <[ \d a..f A..F ]> }

my regex Canonic { ^ [<hex-char>**2]**6 % ':' $ }
my regex Dot     { ^ [<hex-char>**4]**3 % '.' $ }
my regex Integer { ^ \d+                      $ }

# is integer length constrained by first bits XXX

# Valid format names.
my %valid-mac = canonic  => 1,
                dot      => 1,
                integer  => 1, ;

# type-in -- determine input format
sub type-in ( Str $_ --> Str ) {
   return  'canonic' when /<Canonic>/;
   return  'dot'     when /<Dot>/;
   return  'integer' when /<Integer>/;
   die "Unexpected input format: '$_'";
}

# mac2mac() -- Convert a valid EUI-48 mac addr's representation to
# another EUI-48 representation.  The default is to return a lowercase
# hexadecimal-pairs version.
# NOTE: The input is presumed to be a legal MAC address; its form is
# checked but the numerical value is not checked for being reserved.

sub mac2mac( Str $mac is copy, Str $form='canonic', Bool :$uc=False --> Str ) {

    # validate wanted format
    my $to = $form.lc;
    die qq{MAC representation '$to' not recognized.}   # report syntax error
        unless $to eq %valid-mac.keys.any;

    my $ret = do
        with type-in( $mac ) {
            when 'dot'     { dot(     $mac, $to)}
            when 'canonic' { canonic( $mac, $to)}
            when 'integer' { integer( $mac, $to)}
            default { die "Unknown type for data '$mac'" }
        }
    $ret = $uc ?? $ret.uc !! $ret.lc;
}

# Subs that convert mac addresses.  Canonic is the intermediary type,
# although hex-integer would be more efficient.

sub dot( Str $mac is copy, $want --> Str) {
    return $mac if $want eq &?ROUTINE.name;
    my $next = join ':', $mac.comb.grep( {$_ !~~ /\./ }).rotor(2)».join;
    return $next if $want eq 'canonic';
    return canonic( $next, $want );
}

sub integer( Str $mac is copy, $want --> Str) {
    return $mac if $want eq &?ROUTINE.name;
    my $next = join ':', $mac.Int.base(16).comb.rotor(2)».join;
    return $next if $want eq 'canonic';
    return canonic( $next, $want );
}

sub canonic( Str $mac is copy, $want --> Str) {
    given $want {
        when "&?ROUTINE.name()" { return $mac }
        when 'integer' {
            $mac =  $mac.=subst( /':'/, '', :g );
            return parse-base( $mac, 16).Str;
        }
        when 'dot' {
            return join '.', $mac.comb.grep( {$_ !~~ /':'/ }).rotor(4)».join;
        }
    }
}

constant TEST=True;
if TEST {
    my @Test =
            # dot                  canonic           integer
        [ 'abc1.20f1.345a', 'ab:c1:20:f1:34:5a', '188845969716314'],
        [ '1ac2.34f0.b1c2', '1a:c2:34:f0:b1:c2', '29421414166978' ],
    ;

    plan @Test * 24;
    constant $CAN = 'canonic';
    constant $INT = 'integer';
    for @Test -> @t {
        is mac2mac( @t[0], "dot"),      @t[0].lc,   "dot -> dot";
        is mac2mac( @t[0].uc, "dot"),   @t[0].lc,   "uc dot -> dot";
        is mac2mac( @t[0], "dot", :uc), @t[0].uc,   "dot -> uc dot";

        is mac2mac( @t[1]),            @t[1].lc,    "$CAN -> $CAN";
        is mac2mac( @t[1].uc),         @t[1].lc,    "$CAN -> $CAN";
        is mac2mac( @t[1], $CAN, :uc), @t[1].uc,    "uc $CAN -> $CAN";

        is mac2mac( @t[2], $INT),       @t[2],      "$INT -> $INT";
        is mac2mac( @t[2], $INT, :uc ), @t[2],      "$INT -> uc $INT";

        is mac2mac( @t[0] ),              @t[1].lc, "dot -> *";
        is mac2mac( @t[0], :uc ),         @t[1].uc, "dot -> uc *";
        is mac2mac( @t[0], $CAN),         @t[1].lc, "dot -> $CAN";
        is mac2mac( @t[0], $CAN, :uc),    @t[1].uc, "dot -> uc $CAN";
        is mac2mac( @t[0].uc, $CAN, :uc), @t[1].uc, "uc dot -> uc $CAN";
        is mac2mac( @t[0].uc, $CAN ),     @t[1].lc, "uc dot -> $CAN";

        is mac2mac( @t[1], "dot"),        @t[0].lc, "$CAN -> dot";
        is mac2mac( @t[1].uc, "dot"),     @t[0].lc, "uc $CAN -> dot";

        is mac2mac( @t[1], "$INT"),    @t[2].lc,   "$CAN -> $INT";
        is mac2mac( @t[1].uc, "$INT"), @t[2].lc,   "uc $CAN -> $INT";

        is mac2mac( @t[2] ),             @t[1],    "$INT -> *";
        is mac2mac( @t[2], $CAN),        @t[1],    "$INT -> $CAN";
        is mac2mac( @t[2], :uc),         @t[1].uc, "$INT -> uc $CAN";
        is mac2mac( @t[2], $CAN, :uc),   @t[1].uc, "$INT -> uc $CAN";

        is mac2mac( @t[2], "dot"),       @t[0].lc, "$INT -> dot";
        is mac2mac( @t[2], "dot", :uc),  @t[0].uc, "$INT -> dot";
    }
    done-testing;
}


