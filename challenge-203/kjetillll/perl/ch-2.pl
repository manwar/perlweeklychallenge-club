#!/usr/bin/perl
use strict; use warnings;

=pod

Run with arguments to use those as the input list or
run without to run the included tests with this output:

Uses File::Find, a core module (included in all normal Perl installations),
to traverse down the source directory to get all directories.

=cut

use File::Find qw(find);
use File::Path qw(make_path remove_tree);
use Carp       qw(croak);

if( @ARGV ){ copydir(@ARGV) }
else       { run_test('/tmp/challenge-203') }
exit;

sub copydir {
    my($src, $trg) = @_;
    my @d = dirs( $src );
    s/^$src/$trg/ for @d;
    my @e = grep -d, @d;
    croak "ERR: @e already exists! Did nothing!" if @e;
    make_path(@d);
}

sub run_test {

    #-- setup work dir
    my $dir = shift;
    die if $dir ne '/tmp/challenge-203'; #you'd better
    remove_tree($dir); #cleanup if need be
    make_path( map "$dir/a/b/c/$_", 1..5 );
    sub touch { open my $fh, '>', $_ or die"ERR: $!"; close $fh };
    touch for map "$dir/a/b/c/$_/$_.txt", 1,2,3, 5;

    #-- copy directory structure
    copydir( "$dir/a/b/c", "$dir/x/y" );

    #--check
    my @dirs = dirs($dir);
    my @files = files($dir);
    my @dirs_wanted = glob $dir.'{,/a{,/b{,/c{,/{1,2,3,4,5}}}},/x{,/y{,/{1,2,3,4,5}}}}';
    my @files_wanted = map "$dir/a/b/c/$_/$_.txt", 1,2,3, 5;
    print "Checking ".@dirs. " dirs: ", join(';',@dirs) eq join(';',@dirs_wanted) ? 'ok' : 'NOT OK', "\n";
    print "Checking ".@files." files: ", join(';',@files) eq join(';',@files_wanted) ? 'ok' : 'NOT OK', "\n";

    #-- cleanup
    remove_tree($dir);
}

sub dirs  { _traverse(shift,sub{-d}) }
sub files { _traverse(shift,sub{-f}) }
sub _traverse {
    my($dir, $cond, @lst) = @_;
    find( { no_chdir=>1, wanted=>sub{ push @lst, $_ if &$cond } },  $dir );
    sort @lst
}
