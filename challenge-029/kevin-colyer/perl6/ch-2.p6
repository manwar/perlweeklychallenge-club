#!/usr/bin/perl6
use v6;

use Test;

# 29.2 Write a script to demonstrate calling a C function. It could be any user defined or standard C function

use NativeCall;

constant LIBQRENCODE = '/usr/lib/x86_64-linux-gnu/libqrencode.so.3';

# Level of error correction. (lowest to highest)
enum  QRecLevel <QR_ECLEVEL_L QR_ECLEVEL_M QR_ECLEVEL_Q QR_ECLEVEL_H>;

class QRcode is repr('CStruct') {
    has int32           $.version;
    has int32           $.width;
    has Pointer[uint8]  $.data; # sized width*width
}

# QRcode* QRcode_encodeString8bit   (   const char *    string, int     version, QRecLevel  level )
sub QRcode_encodeString8bit ( Str is encoded('utf8'), uint8, uint8 ) returns QRcode is native( LIBQRENCODE ) { * }
sub QRcode_free             ( QRcode )                                              is native( LIBQRENCODE ) { * }

# from qrencode.h...
# Symbol data is represented as an array contains width*width uchars. Each uchar represents a module (dot). If the less significant bit of the uchar is 1, the corresponding module is black. The other bits are meaningless for usual applications, but here its specification is described.
#
# MSB 76543210 LSB
#     |||||||`- 1=black/0=white
#     ||||||`-- data and ecc code area
#     |||||`--- format information
#     ||||`---- version information
#     |||`----- timing pattern
#     ||`------ alignment pattern
#     |`------- finder pattern and separator
#     `-------- non-data modules (format, timing, etc.)
sub is-on           (uint8 $b) { return $b +& 0x01 }
sub is-data         (uint8 $b) { return $b +& 0x02 }
sub is-format       (uint8 $b) { return $b +& 0x04 }
sub is-version      (uint8 $b) { return $b +& 0x08 }
sub is-timing       (uint8 $b) { return $b +& 0x10 }
sub is-alignment    (uint8 $b) { return $b +& 0x20 }
sub is-finder       (uint8 $b) { return $b +& 0x40 }
sub is-non-data     (uint8 $b) { return $b +& 0x80 }

sub qrencode(Str $encode where * !eq "", QRecLevel $level, Bool $explain=False)  {

        # heavy lifting by c library
        my $QR=QRcode_encodeString8bit($encode,0,$level);

        print "  ";
        # note we are reading a pointer directly from memory!!! Care with buffer size!
        for ^$QR.width*$QR.width -> $i {
            my $b = $QR.data[$i];
            my $w="-";

            if $explain {
                $w="#" if is-data($b);
                $w="f" if is-format($b);
                $w="v" if is-version($b);
                $w="t" if is-timing($b);
                $w="a" if is-alignment($b);
                $w="?" if is-finder($b);
                #$w="n" if is-non-data($b); # doesn't seem to tell us anything useful.
            } else { $w="\c[FULL BLOCK]" };

            # lsb has on or off data. libqrencode returns a cube of data and leaves it to callee to create an image of their own choosing.
            print is-on($b) ?? $w x 2 !! "  ";
            print "\n  " if ($i+1) %% $QR.width;
        }
        if $explain { say "\n    ## = Data | ff = format   | vv = version\n  tt = timing | aa= alignment | ?? = finder" };

        QRcode_free($QR);
        # hmmm... seems to persist data
        # say $QR.data[0];
        return
}

multi MAIN( Str $text, Bool :$explain) {
    shell 'clear';
    say "";
    qrencode($text,QR_ECLEVEL_H,$explain);
    say "";
}


multi MAIN('clock',Bool :$explain) {
    loop {
        shell 'clear'; # clear screen
        say "  The time is now...\n";
        qrencode(DateTime.now.hh-mm-ss,QR_ECLEVEL_M, $explain);
        sleep 1;
    }
}
