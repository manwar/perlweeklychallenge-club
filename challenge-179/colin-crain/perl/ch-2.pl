#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       sparkle.pl
#
#       Unicode Sparkline
#         Submitted by: Mohammad S Anwar
#         You are given a list of positive numbers, @n.
# 
#         Write a script to print sparkline in Unicode for the given list of
#         numbers.

#       background
# 
#         Edward Tufte coined the term sparklines in 2006 for
#         "data-intense, design-simple, word-sized graphics", embedded
#         seamlessly within the words in a line of text. The idea is to
#         convey simple graphical information, such as data trending,
#         quickly and without breaking the reader's spatial attention on
#         the page.
# 
#         "Sparklines", Tufte says, "can be placed anywhere that words or
#         numbers or graphics can be placed: in sentences, maps, graphics,
#         tables."
# 
#         Individual words each contain small portions of information.
#         Generally the information content of a single word is imcomplete,
#         but by grouping words together in a linear way more complex ideas
#         can be developed. Similarly sparklines contain a similar kernel
#         of essential information that, incomplete on its own, can be
#         combined inline with a written context to add additional meaning
#         to a context. Rather than forcing the reader to jump back and
#         forth from sideboxed graphic to a textual foundation to provide
#         data context, the sparkline can provide a small significant part
#         of a larger data analysis immediately when required, with the
#         context self-evident.  
# 
#         With the widespread adoption of Unicode and its greatly expanded
#         font sets, users of the technology have been able to construct
#         character-based "words" directly from the graphical elements
#         newly made available. The sparklines exist the same as any other
#         word, allowing them to be integrated directly into a lne of text.
# 
#       method
# 
#         The Unicode font-set provides 8 box graphics of gradient sizing
#         that can be used to construct bar-graphs, and these are commonly
#         used to create sparklines. Thus when given a data set og
#         numerical values the challenge is to divide the range into 8
#         segements and assign each element to a segment. From these a
#         sparkline can be constructed that will show general upward or
#         downward trending in the data, or concentrations of values, for
#         instance, without relying on specific axis values.
# 
#         The problem then becomes one of normalizing the data. We need an
#         overall range for the data provided, and then derive a conversion
#         factor to map this range to the range 1-8. We can then apply this
#         conversion factor (and offset) to the data and take the floor value, yielding
#         an index value 0-7. We then use this index to find the
#         appropriate character.
#        
#         The conversion is not unlike converting from Celsius to
#         Fahrenheit: °F are °C * 9/5, as 100 units in C map to 180 units
#         in F, however thre is an offset, in that the freezing point of
#         water, 0°C, starts at 32°F, because Fahrenheit used salted ice
#         slurry. So after we convert our scale from 0-100 to 0-180, we
#         need to add that 32 to get the proper result.
#      
#         So we get: 
#         
#             input_range  = input_max  - input_min
#             output_range = output_max - output_min = 7 - 0 = 7
#             input_offset = input - input_min
# 
#             output = (output_range/input_range) + input_offset;
#         
#         From there we want the integer component to get range 0-7 for an
#         index
#         
# 
# 
# 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use open ':std', ':encoding(UTF-8)';

use List::MoreUtils qw( minmax );

my @input = (15,2500,35,-4500,55,65,75,8500);

say "@input";
say sparkle( \@input );


sub sparkle( $arr ) {
    my @sparks = qw( ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ █);

    my ($min, $max) = minmax( $arr->@* );
    my $out;

    for ($arr->@*) {
        ## output = (output_range/input_range) + input_offset;
        my $idx = int( (7/($max - $min)) * ($_ - $min) );
        $out .= $sparks[ $idx ];
    }
    return $out;
}
