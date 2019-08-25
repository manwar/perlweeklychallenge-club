use v6;

################################################################################
=begin comment

Perl Weekly Challenge 022
=========================

Task #2
-------
Write a script to implement *Lempel–Ziv–Welch (LZW)* compression algorithm. The
script should have method to *encode/decode* algorithm. The wiki
[ https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch |page] explains
the compression algorithm very nicely.

I must confess, it took me many years to get my head around the compression
algorithm, I finally understood while doing research for the task. So thanks to
*Perl Weekly Challenge*, I can proudly say that now I understand the compression
algorithm. I hope you will enjoy this task as much as I did.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

#
# NB: This programme is a memory hog, and is therefore not suitable for use on
#     large files
#

my UInt constant $DICT-START =   0;
my UInt constant $DICT-END   = 255;

BEGIN say '';

#===============================================================================
sub MAIN
#===============================================================================
(
    Str  :$filename,    #= Name of file to compress
    Str  :$string,      #= Text string to compress
    UInt :$max-code,    #= Maximum dictionary entry value, minimum 255
)
{
    my       @sizes;
    my Str   $text     = init-input($filename, $string, $max-code);
             @sizes[0] = $text.chars;
             @sizes[1] = @sizes[0].chars;
    my Array $lzw;
    my UInt  $entries;
      ($lzw, $entries) = encode($text, $max-code);
             @sizes[2] = $lzw.elems;
    my Str   $decoded  = decode($lzw,  $max-code);
             @sizes[3] = $decoded.chars;

    printf "Number of characters\n" ~
           "  Original: %d\n"       ~
           "  Encoded:  %*d\n"      ~
           "  Decoded:  %d\n", @sizes;

    if @sizes[3] == @sizes[0] && $decoded eq $text
    {
        printf "\nEncoding/decoding successful\n" ~
                 "  Compression ratio:  %.1f\n"   ~
                 "  Space savings:      %.1f%%\n" ~
                 "  Dictionary entries: %d\n",
               (@sizes[0] / @sizes[2]), (1 - (@sizes[2] / @sizes[0])) * 100,
                $entries;
    }
    else
    {
        die "\nERROR: Decoded string does not match original input";
    }

    CATCH
    {
        default 
        {
            $*ERR.say: .message;
        }
    }
}

#-------------------------------------------------------------------------------
sub init-input
#-------------------------------------------------------------------------------
(
    Str   $filename,
    Str   $string,
    UInt  $max-code,
--> Str:D
)
{
    die $*USAGE
        unless $filename.defined xor $string.defined;

    die "Invalid max-code ($max-code)\n$*USAGE"
        if $max-code.defined && $max-code < $DICT-END;

    my Str $text;

    if $filename.defined
    {
        $text = $filename.IO.slurp;
    }
    else
    {
        # Allow command-line specification of newline characters as literal "\n"

        $text = S :g/ \\ n /\n/ given $string;
    }

    return $text;
}

#===============================================================================
sub encode
#===============================================================================
(
    Str:D  $text,
    UInt   $max-code,
--> List:D
)
{
    my blob8 $text-buf   = $text.encode('ISO-8859-1');      # or 'ASCII'
    my       %dictionary = ($DICT-START .. $DICT-END).map: { chr($_) => $_ }
    my UInt  $next-code  =  $DICT-END + 1;
    my Str   $current    = '';
    my Array $output;

    for 0 .. ($text-buf.elems - 1) -> UInt $index
    {
        my Str $character = $text-buf.read-uint8($index).chr;

        $current ~= $character;

        unless %dictionary{$current}:exists
        {
            %dictionary{$current} = $next-code++      # Add new dictionary entry
                unless $max-code.defined && $next-code > $max-code;

            $current = $current.chop;        # Remove last character

            $output.push: %dictionary{$current};

            $current = $character;
        }
    }

    $output.push: %dictionary{$current};

    return $output, %dictionary.elems;
}

#===============================================================================
sub decode
#===============================================================================
(
    Array:D $lzw,
    UInt    $max-code,
--> Str:D
)
{
    my      @dictionary = ($DICT-START .. $DICT-END).map: { chr($_) };
    my UInt $next-code  =  $DICT-END + 1;
    my Str  $previous   = '';
    my Str  $decoded    = '';

    for @$lzw -> $code
    {
        @dictionary[$code] = $previous ~ $previous.substr(0, 1)
            if $code >= $next-code;

        $decoded ~= @dictionary[$code];

        @dictionary[$next-code++] = $previous ~ @dictionary[$code].substr(0, 1)
            unless ($previous eq '') ||
                   ($max-code.defined && $next-code > $max-code);

        $previous = @dictionary[$code];
    }

    return $decoded;
}

################################################################################
