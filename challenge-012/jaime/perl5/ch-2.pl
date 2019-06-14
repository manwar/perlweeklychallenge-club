# Solution by Jaime Corchado, (@tortsnare)[https://twitter.com/tortsnare].
#
# Challenge #2
#
# Write a script that finds the common directory path, given a
# collection of paths and directory separator. For example, if the
# following paths are supplied.
#
# ```
# /a/b/c/d
# /a/b/cd
# /a/b/cc
# /a/b/c/d/e
# ```
#
# and the path separator is `/`. Your script should return `/a/b` as common
# directory path.

my $delim = shift; # delimit a path, for example `/`.

my $pelim = ":"; # delimit paths, for example unix uses `:`.
my @paths = split /$pelim/, shift; # list of paths, for example `/bin:/sbin`.

# at best, the first path is completely common within all paths
my $common = @paths[0];

PATH: for my $path (@paths) {
    next PATH if $path =~ /^$common/; # $common at the start of $path.
    while (($common) = ($common =~ /^(.*)$delim/)) {
	last if $path =~ /^$common/; # otherwise find intersection of $common and $path.
    }
    last PATH unless $common; # stop if a $path is completely unique.
}

($common) = (@paths[0] =~ /^($delim)/) unless $common; # if given, root is always common

print "$common\n";
