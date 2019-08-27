#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $DICT_START =>    0;
const my $DICT_END   =>  255;
const my $USAGE      => "USAGE: perl $0 (--filename=<Str>|--string=<Str>) " .
                        "[--max=<UInt: $DICT_END+>]\n";

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my  @sizes;
    my ($input,
        $max_code) = init_input();
        $sizes[0]  = length  $input;
        $sizes[1]  = length  $sizes[0];
    my ($lzw_aref,
        $entries)  = encode( $input,    $max_code );
        $sizes[2]  = scalar @$lzw_aref;
    my  $decoded   = decode( $lzw_aref, $max_code );
        $sizes[3]  = length  $decoded;

    printf "Number of characters\n" .
           "  Original: %d\n"       .
           "  Encoded:  %*d\n"      .
           "  Decoded:  %d\n", @sizes;

    if ($sizes[3] == $sizes[0] && $decoded eq $input)
    {
        printf "\nEncoding/decoding successful\n" .
                 "  Compression ratio:  %.1f\n"   .
                 "  Space savings:      %.1f%%\n" .
                 "  Dictionary entries: %d\n",
               ($sizes[0] / $sizes[2]), (1 - ($sizes[2] / $sizes[0])) * 100,
                $entries;
    }
    else
    {
        die "ERROR: Decoded string does not match original input\n";
    }
}

#-------------------------------------------------------------------------------
sub init_input
#-------------------------------------------------------------------------------
{
    my ($filename, $string, $max_code);

    GetOptions
    (
        'filename=s' => \$filename,
        'string=s'   => \$string,
        'max_code=i' => \$max_code,

    ) or die $USAGE;

    die $USAGE unless (defined $filename && $filename ne '') xor
                      (defined $string   && $string   ne '');

    die "Invalid max_code ($max_code)\n" . $USAGE
        if defined $max_code && $max_code < $DICT_END;

    if (defined $filename)
    {
        open my $fh, '<', $filename
            or die "Cannot open file \"$filename\" for reading, stopped";

        binmode $fh;        # Uses layer ":raw"
        local   $/;         # Localized slurp mode
        $string = <$fh>;

        close $fh
            or die "Cannot close file \"$filename\", stopped";
    }
    else
    {
        # Allow command-line specification of newline characters as literal "\n"

        $string =~ s{ \\ n }{\r\n}gx;
    }

    return ($string, $max_code);
}

#===============================================================================
sub encode
#===============================================================================
{
    my ($input, $max) = @_;
    my  %dictionary   = map { chr($_) => $_ } $DICT_START .. $DICT_END;
    my  $next_code    = $DICT_END + 1;
    my  $index        = 0;
    my  $current      = '';
    my  $character    = substr $input, $index++, 1;
    my  @output;

    until ($character eq '')
    {
        $current .= $character;

        unless (exists $dictionary{$current})
        {
            $dictionary{$current} = $next_code++      # Add new dictionary entry
                unless defined $max && $next_code > $max;

            $current = substr $current, 0, -1;        # Remove last character

            push @output, $dictionary{$current};

            $current = $character;
        }

        $character = substr $input, $index++, 1;
    }

    push @output, $dictionary{$current};

    return (\@output, scalar keys %dictionary);
}

#===============================================================================
sub decode
#===============================================================================
{
    my ($lzw_aref,
        $max_code)  = @_;
    my  @dictionary = map { chr($_) } $DICT_START .. $DICT_END;
    my  $next_code  = $DICT_END + 1;
    my  $previous   = '';
    my  $output     = '';

    for my $code (@$lzw_aref)
    {
        $dictionary[$code] = $previous . substr($previous, 0, 1)
            if $code >= $next_code;

        $output  .= $dictionary[$code];

        $dictionary[$next_code++] = $previous . substr($dictionary[$code], 0, 1)
            unless ($previous eq '') ||
                   (defined $max_code && $next_code > $max_code);

        $previous = $dictionary[$code];
    }

    return $output;
}

################################################################################

__END__

Reference: Mark Nelson, "LZW Data Compression Revisited" (8 Nov, 2011),
           https://marknelson.us/posts/2011/11/08/lzw-revisited.html
