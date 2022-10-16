use utf8;
use v5.36;
use strict;
use warnings;
##
# You are given a string with possible unicode characters. Create a subroutine 
# sub makeover($str) that replace the unicode characters with their ascii equivalent.
# For this task, let us assume the string only contains letters.
##
use Imager;
use File::Temp q/tempfile/;
use Image::OCR::Tesseract q/get_ocr/;

use constant TEXT_SIZE => 30;
use constant FONT => q#/usr/pkg/share/fonts/X11/TTF/Symbola.ttf#;

sub makeover($s){
    my $image = Imager->new(xsize => 100, ysize => 100);
    my $temp = File::Temp->new(SUFFIX => q/.tiff/);
    my $font = Imager::Font->new(file => FONT) or die "Cannot load " . FONT . " ", Imager->errstr;
    $font->align(string => $s,
                 size => TEXT_SIZE,
                 color => q/white/,
                 x => $image->getwidth/2,
                 y => $image->getheight/2,
                 halign => q/center/,
                 valign => q/center/,
                 image => $image
    );
    $image->write(file => $temp) or die "Cannot save $temp", $image->errstr;
    my $text = get_ocr($temp);
    return $text;
}


MAIN:{
    say makeover(q/ Ã Ê Í Ò Ù /);
}