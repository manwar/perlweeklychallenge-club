# Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm.
# The script should have method to encode/decode algorithm.
# The wiki page explains the compression algorithm very nicely.

use strict;
use bytes;
use constant INIT_DICT_SIZE => 255;

sub encode {
    my $string      = pop;
    my $len         = length $string;

    my $dict_size   = INIT_DICT_SIZE;
    my %dictionary  = map { chr($_) => $_ }0..$dict_size;
    
    my $bin_buff    = "";
    my @buff_out    = ();
    my $pos         = 0;
    my $output      = "";
    my $l           = "";
    my $v           = "";

    while ($pos<$len) {
        my $incr = 1;
        for my $x ($pos+1..$len) {
            $l    = substr $string, $pos, $x-$pos;
            
            if (exists $dictionary{$l}) {
                $v = $dictionary{$l};

                if ($x == $len) {
                    push @buff_out, $v;
                    $dictionary{$l} = ++$dict_size;
                }
            } else {
                $incr = $x - $pos-1;

                push @buff_out, $v;
                $dictionary{$l} = ++$dict_size;
                last;
            }
        }
        $pos+=$incr;
    }
    return @buff_out;
}

sub decode {
    my @buff_in     = @{+pop};
    my %dictionary  = map { $_ => chr }0..INIT_DICT_SIZE;
    my $old         = $buff_in[0];
    my $n           = "";

    my $s           = $dictionary{$old};
    my $c           = substr $s, 0, 1;
    my $ret         = $s;
    my $count       = INIT_DICT_SIZE;

    for (my $i =0; $i < $#buff_in;$i++) {
        $n = $buff_in[$i+1];

        if ( !exists $dictionary{$n} ) {
            $s = $dictionary{$old};
            $s.= $c;
        } else {
            $s = $dictionary{$n};
        }
        $ret .= $s;
        $c = substr $s, 0, 1;
        $dictionary{++$count} = $dictionary{$old}.$c;

        $old = $n;
    }
    return $ret;
}

my $string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
print ("Original String has length ". (length $string)."\n");
print "$string\n\n";

my @compressed = encode($string);
print ("Compressed String has length ". (@compressed)."\n");
print (("@compressed "=~s/\d+ /chr $&/gre)."\n\n");

my $uncompressed = decode(\@compressed);
print ("Uncompressed String has length ". (length $uncompressed)."\n");
print "$uncompressed\n\n";

print "Uncompressed string matches original\n\n" if $uncompressed eq $string;





