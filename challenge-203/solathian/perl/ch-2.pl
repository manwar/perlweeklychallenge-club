#!usr/bin/perl
use v5.36;

use Cwd;
use File::Slurp qw(read_dir);
# Challange 20 - 2 - Copy Directory
# You are given path to two folders, $source and $target.

# Write a script that recursively copy the directory from $source to $target except any files.


# Note: it is assumed that the contents of the source shall be discarded.

copyDir('/a/b/c', '/x/y');

sub copyDir($source, $target)
{
    my $cwd        = getcwd();
    my $targetPath = $cwd;
    
    
    # create target a-Z0-9 _-()*,. are valid characters
    while( $target =~ s"^(\/[a-zA-Z0-9\s_\.,\s\-\(\)\*])""g)
    {
        $targetPath .= $1;
        mkdir $targetPath;
    }

    # create directories
    foreach my $element (read_dir($cwd.$source))
    {
        my $fullPath = $cwd.$source.'/'.$element;
        next if(-f $fullPath);

        mkdir($targetPath.'/'.$element);
    }

}


# Example:
# Input: $source = '/x/y'  and $target = '/a/b/c'

# Source directory structure:

# ├── a
# │   └── b
# │       └── c
# │           ├── 1
# │           │   └── 1.txt
# │           ├── 2
# │           │   └── 2.txt
# │           ├── 3
# │           │   └── 3.txt
# │           ├── 4
# │           └── 5
# │               └── 5.txt

# Target directory structure:

# ├── x
# │   └── y

# Expected Result:

# ├── x
# │   └── y
# |       ├── 1
# │       ├── 2
# │       ├── 3
# │       ├── 4
# │       └── 5