#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;

=begin comment

200-2: Seven Segment 200            Submitted by: Ryan J Thompson

A seven segment display is an electronic component, usually used to display digits. The segments are labeled 'a' through 'g' as shown below:

The encoding of each digit can thus be represented compactly as a truth table:

my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’ enabled.

Write a program that accepts any decimal number and draws that number as a horizontal sequence of ASCII seven segment displays, similar to the following:
                                    a
-------  -------  -------        -------
      |  |     |  |     |      f |     | b
      |  |     |  |     |        |  g  |
-------                          -------
|        |     |  |     |        |     |
|        |     |  |     |      e |     | c
-------  -------  -------        -------
                                    d
To qualify as a seven segment display, each segment must be drawn (or not drawn) according to your @truth table.
=end comment

=begin graphic

  4x5    5x5    3x3  4x3       7x7
0 ----  -----    _    __      8888888
1 |  |  |   |   |_|  |__|     8     8
2 ----  -----   |_|  |__|     8     8
3 |  |  |   |                 8888888
4 ----  -----                 8     8
5                             8     8
6                             8888888
=end graphic


#------------------------------------------------------------------------
#  Font Definition

#   s/b *- a role
#       *- pun-able as is.
#       *- control order of segment assembly, if necessary
#       *- control inter-char space
#
#  Defining a grid array upon which to create glyphs would allow having
#  and sharing of the insections of segments.  This could better emulate
#  displays by avoiding gaps between "adjacent" segments on larger fonts.
#  Overlapping segments seemed against the challenge's spec.

my $basic-font = {
    name => 'basic3x3',
    h => 3,
    w => 3,
    x-space => 1,
    y-space => 1,
    build_order => < a f g b e d c >,
    post-proc => sub ( $char, @glyph) { return @glyph },
    segments => {
            # segment out put for requested state
         a => [ { row => 0, True => ' _ ', False => '   ' }, ],
         f => [ { row => 1, True => '|',   False => ' '   }, ],
         g => [ { row => 1, True => '_',   False => ' '   }, ],
         b => [ { row => 1, True => '|',   False => ' '   }, ],
         e => [ { row => 2, True => '|',   False => ' '   }, ],
         d => [ { row => 2, True => '_',   False => ' '   }, ],
         c => [ { row => 2, True => '|',   False => ' '   }, ],
    }
};

my $uni-font = {
    name => 'uni5x5',
    h => 5,
    w => 5,
    x-space => 2,
    y-space => 1,
    build_order => < f e a d g b c >,
    post-proc => sub ( $char, @glyph) { return @glyph },
    segments => {
        a => [ { row => 0, True => '━━━',  False => '   '  }, ],
        b => [ { row => 0, True => '╻',    False => ' '    },
               { row => 1, True => '┃',    False => ' '    }, ],
        c => [ { row => 2, True => '┒',    False => ' '    },
               { row => 3, True => '┃',    False => ' '    },
               { row => 4, True => '╹',    False => ' '    }, ],
        d => [ { row => 4, True => '━━━',  False => '   '  }, ],
        e => [ { row => 2, True => '┎',    False => ' '    },
               { row => 3, True => '┃   ', False => '    ' },
               { row => 4, True => '╹',    False => ' '    }, ],
        f => [ { row => 0, True => '╻',    False => ' '    },
               { row => 1, True => '┃   ', False => '    ' }, ],
        g => [ { row => 2, True => '━━━',  False => '   '  }, ],
    }
};

my $post-font = {
    name => 'mirror7x7',
    h => 7,
    w => 7,
    x-space => 3,
    y-space => 1,
    post-proc => sub ( $char, @glyph) {
        for @glyph -> $str is rw {
            $str.=subst: /\S/, $char.uc, :g ;
        }
        return @glyph;
    },
    build_order => < a f b d e c g >,
    segments => {
        a => [ { row => 0, True => '-------', False => '       '  }, ],
        f => [ { row => 1, True => '|     ',  False => '      '   },
               { row => 2, True => '|     ',  False => '      '   }, ],
        b => [ { row => 1, True => '|',       False => ' '        },
               { row => 2, True => '|',       False => ' '        }, ],
        g => [ { row => 3, True => '-------', False => '       '  }, ],
        e => [ { row => 4, True => '|     ',  False => '      '   },
               { row => 5, True => '|     ',  False => '      '   }, ],
        c => [ { row => 4, True => '|',       False => ' '        },
               { row => 5, True => '|',       False => ' '        }, ],
        d => [ { row => 6, True => '-------', False => '       '  }, ],
    }
};

#------------------------------------------------------------------------
# s/b a renderer class

constant $SP = ' ';

    # the s7 alphabet by segments active: 0-9, a-f etc., $SP is a blank.
    # 
constant %abc =
          0 => 'abcdef.', 1 => '.bc....', 2 => 'ab.de.g', 3 => 'abcd..g',
          4 => '.bc..fg', 5 => 'a.cd.fg', 6 => 'a.cdefg', 7 => 'abc....',
          8 => 'abcdefg', 9 => 'abc..fg', a => 'abc.efg', b => '..cdefg',
          c => 'a..def.', d => '.bcde.g', e => 'a..defg', f => 'a...efg',
          h => '..c.efg', i => '..c....', j => '.bcde..', l => '...def.',
          o => '..cde.g', n => '..c.e.g', p => 'ab..efg', u => '..cde..',
        $SP => '.......',
;

#Build and cache a font.
sub build-font( $font = $basic-font --> Hash) {
    my %return;
    %return<font-def> = $font;
    for %abc.keys.sort -> $c {
        # decode-char
        my %segdef = $font<segments>;
        my %ref = [Z=>] <a b c d e f g >,
                %abc{$c}.comb.Array.map({ $_= $_ !~~ '.' ?? True !! False});
        my @order = map { Pair.new( $_, %ref{$_})}, $font<build_order>.flat;

        my @image =  '' x $font<h>;
        for @order -> ( :key($seg), :value($active) ) {
            for ^%segdef{$seg} -> $i {
                next unless %segdef{$seg}[$i].defined;   # not in row
                @image[ %segdef{$seg}[$i]<row>] ~= %segdef{$seg}[$i]{$active};
            }
        }
        @image = $font<post-proc>( $c, @image);
        %return{$c} = @image;
    }
    %return;
}

sub render( %built-font, $in = '200 200' --> Array) {
    my @return;
    my $font = %built-font<font-def>;

    for ^$font<h> -> $r {
        @return[$r] = '';
    }
    for $in.comb -> $ch {
        for ^$font<h> -> $r {
            @return[$r] ~= %built-font{$ch}[$r] ~ (' ' x $font<x-space>);
        }
    }
    @return
}

sub print7( @rendered ) {
    print "\n";
    for ^@rendered -> $n {
        say @rendered[$n];
    }
}

#------------------------------------------------------------------------
# user
my %basic =  build-font( $basic-font );
my %uni = build-font( $uni-font);
my %post = build-font( $post-font);

print7( render( %basic, '01234 56789'));
print7( render( %basic, 'abcdefhijlnopu'));

print7( render(%uni,'0123456789'));
print7( render(%uni, 'abcdefjlnou'));

print7( render(%post,'01234567'));
print7( render(%post,'89abcdef'));
print7( render(%post,'jlnou'));
print7( render(%post,' '));

print7( render(%uni, 'happi'));
print7( render(%post, '200 2 u'));
print7( render(%basic, 'happi 200 2 u'));

