# Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm.
# The script should have method to encode/decode algorithm.
# The wiki page explains the compression algorithm very nicely.

use strict;
use bytes;
use constant INIT_DICT_SIZE => 255;

sub encode {
    my $string      = pop;
    my $len         = length $string;

    #Initialize the dictionary to hash
    my $dict_size   = INIT_DICT_SIZE;
    my %dictionary  = map { chr $_ => $_ } 0..$dict_size;

    #Initialize variables
    my $prev        = substr $string, 0,1;
    my $curr        = "";

    my $code        = INIT_DICT_SIZE+1;
    my @buff_out    = ();

    #Go through the characters and build-up the $dictionary
    for my $i (0..$len-1) {
        if ($i != $len-1) {
            $curr .= substr $string,$i + 1,1;
        }
        if (exists $dictionary{$prev.$curr}) {
            $prev .= $curr;
        } else {
            push @buff_out, $dictionary{$prev};
            $dictionary{$prev.$curr} = $code;
            $code++;
            $prev = $curr;
        }
        $curr = "";
    }
    push @buff_out, $dictionary{$prev};
    return @buff_out;
}

sub decode {
    my @buff_in     = @{+pop};

    #Initialize dictionary using numbers as keys
    #Using array would work too
    my %dictionary  = map { $_ => chr }0..INIT_DICT_SIZE;

    #Initialize the first value from @buff_in to $o
    my $o           = $buff_in[0];
    my $n           = "";
    my $s           = $dictionary{$o};
    my $c           = substr $s, 0, 1;
    my $ret         = $s;


    my $count       = INIT_DICT_SIZE;

    #Go through the codes in @buff_in
    for (my $i =0; $i < $#buff_in;$i++) {

        #Store the $n-ext value
        $n = $buff_in[$i+1];

        #Check if $n-ext value is in the dictionary
        if ( exists $dictionary{$n} ) {
            $s = $dictionary{$n};
        } else {
            $s = $dictionary{$o};
            $s.= $c;
        }

        #Update return value
        $ret .= $s;
        $c = substr $s, 0, 1;

        #Update dictionary
        $dictionary{++$count} = $dictionary{$o}.$c;

        #Update store $n to $o as
        #new value becomes old and be replaced on next iteration
        $o = $n;
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
