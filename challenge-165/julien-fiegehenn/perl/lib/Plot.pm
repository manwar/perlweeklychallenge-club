package Plot;

use strict;
use warnings;

use SVG;
use List::Util 'max';

=head1 NAME

Plot - Plot points and lines for Challenge 165

=head1 FUNCTIONS

=head2 plot(@input)

Takes a list of array refs of either two or four numbers and creates an I<output.svg> file
in the working directory.

    plot( [ 1, 1 ] ); # one point at x=1, y=1
    plot( [ 1, 1 ], [ 5, 5 ] ); # a line from x=1, y=1 to x=5, y=5

=cut

sub plot {
    my (@input) = @_;

    my $svg    = SVG->new;
    my $points = $svg->group(
        id    => 'points',
        style => {
            stroke => 'orange',
            fill   => 'orange'
        },
    );
    my $lines = $svg->group(
        id    => 'lines',
        style => {
            stroke         => 'blue',
            fill           => 'blue',
            'stroke-width' => 3,
        },
    );

    # set the minimum size of the canvas
    my $size = 190;
    foreach my $record (@input) {
        if ( @$record == 2 ) {
            $points->circle( cx => $record->[0], cy => $record->[1], r => 3 );
        }
        else {
            $lines->line(
                x1 => $record->[0],
                y1 => $record->[1],
                x2 => $record->[2],
                y2 => $record->[3]
            );
        }
        
        # update the image size
        $size = max($size, @$record);
    }

    # Set the image size... there is no proper interface for this in SVG
    # so we have to rumage around in the internals. We add 10 extra so points
    # don't hug the wall.
    $svg->{width} = $svg->{height} = $size + 10;
    
    # write to disk
    open my $fh, '>', 'output.svg' or die $!;
    print $fh $svg->xmlify;
}

=head1 AUTHOR

Julien Fiegehenn <simbabque@cpan.org>

=cut

1;