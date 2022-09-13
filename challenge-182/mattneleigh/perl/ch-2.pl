#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @paths = (
    # Given paths
    "/a/b/c/1/x.pl",
    "/a/b/c/d/e/2/x.pl",
    "/a/b/c/d/3/x.pl",
    "/a/b/c/4/x.pl",
    "/a/b/c/d/5/x.pl",

    # Additional special path(s) (uncomment
    # to test)
#    "/usr/local/bin/x.pl"
);
my $path;

# Uncomment to test behavior when an empty
# list is passed
# @paths = ();

# Uncomment to test behavior when one path
# is passed
# @paths = ("/a/b/c/d/e/x.pl");

printf(
    "\nInput:\n%s\n\n",
    join("\n", map("    ".$_, @paths))
);
printf(
    "Output:\n    %s\n\n",
    # Capture of return value en-passant is deliberate
    defined($path = deepest_common_path(@paths)) ? $path : "UNDEF"
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the deepest common path among a list of absolute paths to a set of
# files
# Takes one argument:
# * A list of absolute paths to files
# Returns on success:
# * The deepest common path amongst the specified paths; this will be "/" if
#   nothing below that matches
# Returns on error:
# * undef if no paths are specified
################################################################################
sub deepest_common_path{
    use File::Spec;

    my @split_paths;
    my @common_path;
    my $j;
    my $name = "";

    # See how many paths we have
    $j = scalar(@_);

    # Special case- no path
    return(undef)
        unless($j);

    # Special case- one path
    if($j == 1){
        (undef, $name, undef) = File::Spec->splitpath($_[0]);
        
        return($name);
    }

    # Split the paths up into their component directories
    # and store them- without their filenames
    foreach(@_){
        (undef, $name, undef) = File::Spec->splitpath($_);
        push(@split_paths, [ File::Spec->splitdir($name) ]);
    }

    $name = "";
    $j = 0;
    while(defined($name)){
        # Compare the name at position $j across all
        # paths- initialize with the first path then
        # loop with $i from the second path to the
        # last
        $name = $split_paths[0][$j];
        for my $i (1 .. $#split_paths){
            unless(
                defined($split_paths[$i][$j])
                &&
                # This test will fail if $name is undef
                $split_paths[$i][$j] eq $name
            ){
                # We ran out of dirs in one of the paths, or
                # found a dir whose name didn't match- prepare
                # to break out of both loops
                $name = undef;
                last;
            }
        }
        if(defined($name)){
            # Name matched across all paths- add it to
            # the common path and increment $j
            push(@common_path, $name);
            $j++;
        }
    }

    # Combine the dirs of the common common path into
    # a single string, and return
    return(File::Spec->catdir(@common_path));

}



