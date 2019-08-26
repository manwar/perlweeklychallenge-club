#!/usr/bin/perl6
use v6;

use Test;

# 22.2 Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm. The script should have method to encode/decode algorithm. The https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch page explains the compression algorithm very nicely.

# ASSUMPTIONS
# Dictionary is hard set to ASCII upper case
# 5 bits raising to 12 bits. No overflow checking if dict overflows!
# TODO - better dictionary, bit packing, dict overflowing...

constant  @sharedDict= '#', 'A' ... 'Z';

#| tests
sub MAIN(  Bool :$debug=False)
{
    my $test="TOBEORNOTTOBEORTOBEORNOT#";

    my $output= LZWencode($test,$debug);
    my @decode= [20 => 5, 15 => 5, 2 => 5, 5 => 5, 15 => 5, 18 => 6, 14 => 6, 15 => 6, 20 => 6, 27 => 6, 29 => 6, 31 => 6, 36 => 6, 30 => 6, 32 => 6, 34 => 6, 0 => 6];
    is $output,@decode,"testing encode";

    $output= LZWdecode(@decode,$debug);
    is $output,$test,"testing decode";

    # Roundtrip tests
    is LZWdecode(LZWencode($test,False),False),$test,"roundtrip coder and decoder";
    my $bitsInput=$test.chars*8;
    my $bitsOutput=LZWencode($test,False).reduce: {$^a.kv[1] + $^b.kv[1] };
    say "[$test]\n   uncompressed $bitsInput / compressed $bitsOutput = " ~ floor((1-$bitsOutput/$bitsInput)*100) ~ "% of input";

    $test="THEQUICKBROWNFOZJUMPEDOVERTHELAZYDOGITDIDITSEVERALTIMESWHATFUN#";
    is LZWdecode(LZWencode($test,False),False),$test,"roundtrip coder and decoder longer";
    $bitsInput=$test.chars*8;
    $bitsOutput=LZWencode($test,False).reduce: {$^a.kv[1] + $^b.kv[1] };
    say "[$test]\n   uncompressed $bitsInput / compressed $bitsOutput = " ~ floor((1-$bitsOutput/$bitsInput)*100) ~ "% of input";

    say "Note: Dictionary initialised length {@sharedDict.elems}, {@sharedDict.elems*8} bits";
}

sub LZWencode($input is copy, $debug) {
    # using encoder algorithm from wikipedia page
    #1 Initialize the dictionary to contain all strings of length one.
    my @dict= @sharedDict;
    say @dict if $debug;
    my $bits=5; # ranges to 12
    my $extendDict=2**$bits;
    my @encbuf;
    my $W;

    #2 Find the longest string W in the dictionary that matches the current input.
    while $input.chars {
        $W="";

        # $i is index of current W
        my $i=-1;
        for (0..^@dict.elems).reverse -> $j {
            if $input.starts-with(@dict[$j]) {
                $W=@dict[$j];
                say "\nFound [$W] at index $j"  if $debug;
                $i=$j;
                last;
            }
        }
        die "[{$input.substr(0,1)}] is not in initial dictionary: Invalid input" if $i==-1;
        #3 Emit the dictionary index for W to output and remove W from the input.

        say "#3 [$W] emitting $i using $bits bits" if $debug;
        @encbuf.push( $i => +$bits );

        # If found end code, finish...
        last if $i==0;

        $input=$input.substr($W.chars,*);

        #4 Add W followed by the next symbol in the input to the dictionary.
        say "adding to dict [$W"~$input.substr(0,1) ~"] at index {@dict.elems}"  if $debug ;
        @dict.push($W ~ $input.substr(0,1)) ;

        if @dict.elems>=$extendDict {
            $extendDict*=2;
            $bits++;
            say "Increasing bits used to $bits"  if $debug;
        }

    #5 Go to Step 2.
    }
    return @encbuf;
}

sub LZWdecode(@input, $debug) {
    # similar to encoder but just decode using dictionary as look up. Take care to continue to build dictionary as we go.
    # Keep count of input bit stream width for unpacking

    # Initialize the dictionary to contain all strings of length one.
    my @dict= @sharedDict;
    say @dict if $debug;

    my $bits=5; # ranges to 12
    my $extendDict=2**$bits;
    my $decode;
    my $W;

    while @input.elems {

        my $i= @input.shift.kv[0];
        # $i is index into dict.
        $W=@dict[$i];
        say "\nFound [$W] at index $i"  if $debug;

        # add W to decoded buffer

        say "#3 [$W] decodes $i " if $debug;
        $decode~=$W;

        # If found end code, finish...
        last if $i==0;

        #4 Add W followed by the FIRST LETTER OF the next symbol in the input to the dictionary.
        my $add = $W ~ @dict[ @input[0].kv[0] ].substr( 0, 1 );
        say "adding to dict $add" if $debug ;
        @dict.push($add) ;

        if @dict.elems>=$extendDict {
            $extendDict*=2;
            $bits++;
            say "Increasing bits used to $bits"  if $debug;
        }
    }
    return $decode;
}
