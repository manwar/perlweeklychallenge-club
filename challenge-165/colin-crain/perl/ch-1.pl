#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       scriving-pictures.pl
#
#       Scalable Vector Graphics (SVG)
#         Submitted by: Ryan J Thompson
# 
#         Scalable Vector Graphics (SVG) are not made of pixels, but lines,
#         ellipses, and curves, that can be scaled to any size without any
#         loss of quality. If you have ever tried to resize a small JPG or
#         PNG, you know what I mean by “loss of quality”! What many people
#         do not know about SVG files is, they are simply XML files, so
#         they can easily be generated programmatically.
# 
#         For this task, you may use external library, such as Perl’s SVG
#         library, maintained in recent years by our very own Mohammad S
#         Anwar. You can instead generate the XML yourself; it’s actually
#         quite simple. The source for the example image for Task #2 might
#         be instructive.
# 
#         Your task is to accept a series of points and lines in the
#         following format, one per line, in arbitrary order:
# 
#             Point: x,y 
#             Line: x1,y1,x2,y2
# 
#         Example:
#             53,10
#             53,10,23,30
#             23,30
# 
#         Then, generate an SVG file plotting all points, and all lines. If
#         done correctly, you can view the output .svg file in your
#         browser.
# 
#       A Definition:
#     
#         scrive
# 
#         Etymology
#             Related to scribe.
# 
#         Verb
#             scrive (third-person singular simple present scrives, present
#             participle **scriving**, simple past and past participle scrived)
# 
#             **To describe; to draw a line with a pointed tool.**
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




## SVG package
package SVG;
use Moo;
use feature qw(signatures);
no warnings 'experimental::signatures';
{
    has groups        => ( 
        is      => 'rw' ,
        default => sub { return [] } );
    has height        => ( is      => 'rw' );
    has width         => ( is      => 'rw' );

    around BUILDARGS => sub {
        my ( $orig, $class, @args ) = @_;
        return {    height => $args[0],
                    width  => $args[1]  };        
    };

    sub group( $self, $id, $attr ) {
        push $self->groups->@*, [$id, $attr, []]
    }

    sub add( $self, $item ){
        push $self->groups->[-1]->[2]->@*, $item;
    }

## supported object primitives 
    
    sub circle( $self, $x, $y, $r=3) {
    ## default radius 3 for single point
        return qq(<circle cx="${x}" cy="${y}" r="${r}" />);
    }

    sub line( $self, $x1, $y1, $x2, $y2 ) {
        return qq(<line x1="${x1}" x2="${x2}" y1="${y1}" y2="${y2}" />);
    }

## 
    sub make_SVG( $self ) {
        my $h   = $self->height;
        my $w   = $self->width;

        my $xml = <<~XML;
            <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
            <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
            <svg height="${h}" width="${w}" 
                xmlns="http://www.w3.org/2000/svg" 
                xmlns:svg="http://www.w3.org/2000/svg" 
                xmlns:xlink="http://www.w3.org/1999/xlink">
            XML
        for my $g ( $self->groups->@* ){
            my $tag = qq(<g id="$g->[0]"  );
            $tag   .= qq($_="$g->[1]->{$_}" ).' ' for keys $g->[1]->%*;
            $tag   .= qq(>\n);
            $tag   .= qq(    $_\n) for $g->[2]->@*;
            $tag   .= qq(</g>\n);
        
            $xml .= $tag;
        }
        $xml .= qq(</svg>\n);
        return $xml;
    }
}

package main;

## read input from file
my $filename = shift @ARGV || 'svg-data.txt';
open my $in_fh, "<", $filename or die "can't open $filename for input: $!\n";

## gather line and point data into lists
my @points;
my @lines;

while (<$in_fh>) {
    chomp;
    /^(\d+),(\d+)$/             and push @points, [$1,$2];
    /^(\d+),(\d+),(\d+),(\d+)$/ and push @lines,  [$1,$2,$3,$4];
}

## construct SGV formatted data string
my $svg = new SVG(200,300);
my $attr;

$attr  = { "stroke" => "blue",  "stroke-width" => "4" };
$svg->group( "lines", $attr);
$svg->add( $svg->line($_->@*) ) for @lines;

$attr = { "fill"=>"red" };
$svg->group( "circle", $attr);
$svg->add( $svg->circle($_->@*) ) for @points;

my $out = $svg->make_SVG;

## print to file, based on input filename
my ($outfile) = $filename =~ /^(.*)\./;
open my $out_fh, ">", "./${outfile}.svg" or die "can't open file ./${outfile}.svg: $!";
say $out_fh $out;
close $out_fh;


=cut

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="200" width="300" 
    xmlns="http://www.w3.org/2000/svg" 
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns:xlink="http://www.w3.org/1999/xlink">
<g id="lines"  stroke="blue"  stroke-width="4"  >
    <line x1="53" x2="23" y1="10" y2="30" />
</g>
<g id="circle"  fill="red"  >
    <circle cx="53" cy="10" r="3" />
    <circle cx="23" cy="30" r="3" />
</g>
</svg>

