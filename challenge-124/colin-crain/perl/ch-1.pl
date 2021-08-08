#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       venus-was-her-name.pl
#
#       Happy Women Day
#         Submitted by: Mohammad S Anwar
#         Write a script to print the Venus Symbol, international gender symbol
#         for women. Please feel free to use any character.
# 
#             ^^^^^
#            ^     ^
#           ^       ^
#          ^         ^
#          ^         ^
#          ^         ^
#          ^         ^
#          ^         ^
#           ^       ^
#            ^     ^
#             ^^^^^
#               ^
#               ^
#               ^
#             ^^^^^
#               ^
#               ^
# 
#         method: 
# 
#             Somehow I feel confident some submissions from the team will copy
#             the above to a heredoc and print it out. I mean, it does fulfill
#             the requirement.
# 
#             But I am not that person.
# 
#             Why not? Well for I suppose the main reason is respect: I feel
#             that trivializing the task reflects poorly on the motivation
#             behind it, and trivializing International Women's Day, or any day
#             you want to call Women's Day for that matter, is just not
#             something I would ever want to do. I am and always have been a big
#             fan of women. I'm more than capable of trivializing worthless
#             ideas, don't get me wrong. But not this, no, not this. I'm going
#             to do this right, whatever that means.
# 
#             So what do we do? Well it's been quite a long time since I've done
#             any graphics programming, so how about that? Draw a circle and two
#             rectangles. Maybe out of X chromosones.
# 
#             To draw the circle we'll use Bresenham’s algorithm to draw the
#             best "pixels" in a "screen buffer", in this case a 2-dimensional
#             array. We can then write a rectangle tool and draw a vertical bar,
#             and another horizontal bar bisecting it. Because we're using a
#             buffer intermediate we can just write to the elements we need
#             filled in and not care about the canvas.
# 
#             About that: this is another place Perl's autovivifing arrays
#             really shine, because we don't need to precalculate the canvas
#             size. We can start drawing in and once the drawing is complete we
#             scan through the rows and transform undefined elements into
#             spaces, or whatever we define a space to be.
# 
#             The right edge will be invisibly ragged if we use spaces, so we
#             won't choose to do anything about it. As long as we use a
#             monospaced font, or at least two characters that match widths, all
#             the alignment will work out.
# 
#         Perl Notes:
# 
#             the implementation of Bresenham's algorithm I used chooses
#             the best single pixel to draw a 45° arc, flipped and mirrored
#             8 ways. After a little experimentation I decided the best
#             looking result to widen the line was to draw another circle
#             inside it, an another inside that. This led to the idea of a
#             standard width, to be followed in the rectangular blocks as
#             well. The standard length became the radius of the circle and
#             the lengths of the bars.
# 
#             I did fiddle the height of the vertical bar because good
#             design is good design. Round numbers are useless if it looks
#             bad. 
# 
#             The width, the font weight, became 1/5 the radius, or 1/10
#             the character width. That feels right; it's hard-coded but
#             easily configureed in one place. So the size of the Venus
#             drawing is specified by one parameter now, being half the
#             final width or 1/3.2 the height.
# 
#             SO... I added some noise, and mixed up the characters to give
#             it more drama. There's a chance now a set character will move
#             aboiut in a brownian manner, and if it moves it becomes a
#             venus symbol. The original character remains intact unless it
#             gets overwritten. Then an additional layer of noise with just
#             dots, that won't overwite an existing character. The noise
#             function is asymetric a bit, drifting to the lower right,
#             giving it some dynamism.
# 
#             The whole process reminds me of tweaking a Renderman shader
#             or something — fine tuning the constants to whatever looks
#             right.
# 
#             Now I see a crowd forming, perhaps at a march, joined up
#             together to form a Venus symbol, drifting in from the lower
#             right. I'm really happy with what I came up with,  and it's
#             entirely worth the effort. But women, in general, are, so
#             that's consistant. 


#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

binmode STDOUT, ':utf8';

use POSIX qw( round );

### ### ### cfg 

use constant { SPACE  => ' ' };
use constant { CHAR   => '⚐︎︎' };
use constant { WOMAN  => '♀︎' };
use constant { DUST   => '.' };

## all of these are pretty much voodoo, set to what looks good
use constant { CANVAS_MULTIPLIER   => 1.2 };  ## extra whitespace to canvas
use constant { FONT_WEIGHT         => 3.5 };  ## line width ratio to radius
use constant { CROSS_HEIGHT        => 1.2 };  ## ratio to radius
use constant { BAR_PLACEMENT       => 1.5 };  ## half way down vertical bar
use constant { NOISE_FACTOR        => 2.2 };  ## ??? larger is more
use constant { NOISE_SCALE_FACTOR  => 2 };    ## ??? scales the scaling 
use constant { DUST_SCALE          => 1.4 };  ## larger dust spread

### ### ### /cfg



### ### ### INPUT
my $size = shift @ARGV || 20;   ## default radius 20 chars



### init globals based on config

our $cen_rows = $size * CANVAS_MULTIPLIER;
our $cen_cols = $size * CANVAS_MULTIPLIER;
our $rad      = $size ;
our $width    = round( $size/FONT_WEIGHT );      ## round vs. truncation
our $buf      = [];

### ### ### main

draw_circle(    $cen_rows, $cen_cols, $rad-$_ ) for (0..$width-1);

draw_rectangle( $cen_rows + $rad, 
                $cen_cols - ($width/2),          ## centered at half canvas
                $rad * CROSS_HEIGHT, 
                $width );
                
draw_rectangle( $cen_rows + $rad * BAR_PLACEMENT, 
                $cen_cols - ($rad/2),            ## centered at half canvas
                $width, 
                $rad );

add_noisy_crowd(NOISE_FACTOR);

print_buffer();

### ### ### /main

sub draw_circle ( $cen_rows, $cen_cols, $rad ) {
## Bresenham's algorithm for a circle
    my $x = 0;
    my $y = $rad;
    my $d = 3 - 2 * $rad;
    
    draw_circle_to_buffer( $cen_rows, $cen_cols, $x, $y );
    
    while ( $y >= $x ) {
        $x++;
        if ($d > 0) {
            $y--;
            $d += 4 * ( $x - $y ) + 10;

        }
        else {
            $d += 4 * $x + 6;
        }
        draw_circle_to_buffer( $cen_rows, $cen_cols, $x, $y );
    }
}

sub draw_circle_to_buffer ( $cen_rows, $cen_cols, $x, $y ) {
    $buf->[$cen_rows+$x][$cen_cols+$y]
        = $buf->[$cen_rows-$x][$cen_cols+$y]
        = $buf->[$cen_rows+$x][$cen_cols-$y]
        = $buf->[$cen_rows-$x][$cen_cols-$y]
        = $buf->[$cen_rows+$y][$cen_cols+$x]
        = $buf->[$cen_rows-$y][$cen_cols+$x]
        = $buf->[$cen_rows+$y][$cen_cols-$x]
        = $buf->[$cen_rows-$y][$cen_cols-$x]
        = CHAR;
}

sub noise ($scale) {
## a tool to add noise to pixel placement - this is pretty much a magic
## function that is tuned to look right, whatever that means. Randomness
## falls off polynomially.
    srand;
    return int (rand($scale)**2 - $scale/2);
    $scale *= NOISE_SCALE_FACTOR;
    return int( (rand($scale) - $scale/2) ** 2 );
}


sub print_buffer {
    respace_buffer();
    say "$_->@*"  for $buf->@*;
}

sub respace_buffer {
## before printing (or adding noise, as it works out) we need to make sure
## the canvas is defined. Perhaps we should have gone with that precomputed
## and inititated canvas to start after all... Oh well. This works. Apply
## as necessary. This way give us more dynamic freedom with adding noise or
## whatnot. 
    for my $row ( 0..$buf->$#* ) {
        for my $col ( 0..$buf->[$row]->$#*)  {
            $buf->[$row][$col] = SPACE if not defined $buf->[$row][$col];
        }
    }
}

sub draw_rectangle ( $upper_left_row, $upper_left_col, $rows, $cols ) {
## upper left point, height and width 
    for my $row ( $upper_left_row..$upper_left_row + $rows ) {
        for my $col ($upper_left_col..$upper_left_col + $cols) {
            $buf->[$row][$col] = CHAR;
        }
    }  
}

sub add_noisy_crowd ($level){
## Pure artistic magic. Moves drawn chars with Brownian statistical
## roll-off and replaces the CHAR with a WOMAN, currently configured as a
## Unicode Venus symbol. Then creates much more random noise made up of
## dots, the "dust", based on the CHAR placement, but leaves any already
## defined elements alone, only adding new dots within a much larger random
## radius. The noise function at present also drifts slightly to the right
## and down; this is allowed by intent to dynamically draw the eye. It's
## just good composition. The dust is limited to the undefined spaces of
## the grid, the right and down, for the same reason. The artistic tuning
## of the `noise()` function, parameters and overwrite behavior is all a
## continual work-in-progress. I do like it as it is but it need not stay
## this way.

    respace_buffer();                     ## prevent dust from filling image
    for my $row ( 0..$buf->$#* ) {
        for my $col ( 0..$buf->[$row]->$#*)  {
            if ( defined $buf->[$row][$col] && $buf->[$row][$col] eq CHAR ) {
                my $x = $row + noise($level);
                my $y = $col + noise($level);
                $buf->[$x][$y] = WOMAN;   ## keep original char, but 
                                          ## overwrite venus symbols
                                          ## as it happens
                
                $x += noise($level+DUST_SCALE);
                $y += noise($level+DUST_SCALE);
                $buf->[$x][$y] //= DUST;  ## add dust to surrounding area
                                          ## but do not overwrite
                                          ## (only adds to undefined areas at 
                                          ## the right edge and below,
                                          ## giving a pleasing look)
            }
        }
    }
}
