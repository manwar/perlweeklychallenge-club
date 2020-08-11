use v6;

################################################################################
=begin comment

Perl Weekly Challenge 028
=========================

Task #1
-------
Write a script to check the file content without actually reading the content.
It should accept file name with path as command line argument and print *"The
file content is binary."* or else *"The file content is ascii."* accordingly.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use File::Util:from<Perl5> <file_type>;

BEGIN say '';

#===============================================================================
sub MAIN(Str:D $path)
#===============================================================================
{
    my Str $description = ! .e ?? 'This does not exist'      !!
                            .d ?? 'This is a directory'      !!
                          ! .f ?? 'This is not a plain file' !!
                            .z ?? 'The file is empty'        !! 'OK'
               given $path.IO;

    if $description eq 'OK'
    {
        my Str @types = file_type($path);

        if @types.elems == 2 && @types[0] eq 'PLAIN'
        {
            my Str $t1   = @types[1];
            $description = $t1 eq 'TEXT'   ?? 'The file content is text'   !!
                           $t1 eq 'BINARY' ?? 'The file content is binary' !!
                      'ERROR: The file content is neither text nor binary';
        }
        else
        {
            $description = 'ERROR: Unexpected file types: ' ~ @types.join(', ');
        }
    }

    qq{"$path": $description}.say;
}

################################################################################
