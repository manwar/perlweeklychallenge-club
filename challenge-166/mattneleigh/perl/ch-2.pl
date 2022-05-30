#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @dirs = splice(@ARGV, 0);
my %dir_contents_table;
my $max_length = 0;
my $output_format;

# The original problem specified three directories but
# this system will work with two or more
die("E: must provide at least two directories\n")
    if(scalar(@dirs) < 2);

# Alphabetize directories
@dirs = sort(@dirs);

# Loop over the specified directories
foreach my $dir (@dirs){
    my $dirhandle;
    my $length = length($dir);

    # Update the max file/dir name length seen
    $max_length = $length
        if($length > $max_length);

    opendir($dirhandle, $dir)
        or die("E: Could not open directory $dir: $!");

    # Loop over the contents of the directory
    while(my $file = readdir($dirhandle)){
        # Skip "." and ".."
        next if($file =~ m/^\.{1,2}$/);

        # If the file is a directory, append a slash
        $file .= "/"
            if( -d $dir."/".$file);

        # Update the max file/dir name length seen
        $length = length($file);
        $max_length = $length
            if($length > $max_length);

        # Note that we saw a file with this name in this dir
        $dir_contents_table{$file}{$dir} = 1;
    }

    closedir($dirhandle)
        or die("E: Could not close directory $dir: $!");

}


# Set up an output format befitting the size and amount
# of data we've examined
$output_format = join(
    " | ",
    map("%-" . $max_length . "s", 0 .. $#dirs)
) . "\n";

# Print out a header with dir names
print("\n");
printf($output_format, @dirs);
printf($output_format, map("-" x $max_length, 0 .. $#dirs));

# Look up and output the filenames that were not found
# in every specified directory
foreach my $file (sort(keys(%dir_contents_table))){
    if(scalar(keys(%{$dir_contents_table{$file}})) != scalar(@dirs)){
        # There was at least one dir that did not have this file
        printf(
            $output_format,
            # If $dir_contents_table{$file}{$_} is true, that file
            # had been seen in the directory named in $_
            map($dir_contents_table{$file}{$_} ? $file : "", @dirs)
        );
    }
}

print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



