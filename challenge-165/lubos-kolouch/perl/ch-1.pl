use strict;
use warnings;
use XML::Writer;
use IO::File;

my $output = IO::File->new(">output.svg");
my $writer = XML::Writer->new( OUTPUT => $output );

$writer->startTag(
    "svg",
    'xmlns'   => "http://www.w3.org/2000/svg",
    'version' => "1.1"
);

my @points = ( [ 53, 10 ], [ 23, 30 ] );
my @lines  = ( [ 53, 10, 23, 30 ] );

foreach my $point (@points) {
    $writer->emptyTag(
        "circle",
        'cx'     => $point->[0],
        'cy'     => $point->[1],
        'r'      => "1",
        'stroke' => "black",
        'fill'   => "black"
    );
}

foreach my $line (@lines) {
    $writer->emptyTag(
        "line",
        'x1'     => $line->[0],
        'y1'     => $line->[1],
        'x2'     => $line->[2],
        'y2'     => $line->[3],
        'stroke' => "black"
    );
}

$writer->endTag("svg");
$writer->end();
$output->close();
