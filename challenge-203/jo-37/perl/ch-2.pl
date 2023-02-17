#!/usr/bin/perl -s

use v5.18;
use Test2::V0;

use File::Find;
use autodie;
use experimental qw(signatures lexical_subs);

our ($tests, $examples);

# For testing only:
use if $tests || $examples, 'File::Temp';
use if $tests || $examples, 'File::DirCompare';
#


run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [SOURCE TARGET]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SOURCE TARGET
    Source and target directories

EOS


### Input and Output

copy_dirs(@ARGV);


### Implementation

# Find directories in the source tree and create corresponding
# directories in the target tree if no such file exists yet.  At least
# the parent directory of the target must exist beforehand.
sub copy_dirs ($source, $target) {
    find {
        # Make sure the source path is not interpreted as a regex.
        wanted => sub {-d && s/^\Q$source\E/$target/ && !-e && mkdir},
        no_chdir => 1}, $source;
}


### Examples and tests

# This task has an interesting twist: The testing appears to be more
# challenging than the implementation itself.
sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        check_copy_dirs(
            [qw(a/ a/b/ a/b/c/ a/b/c/1/ a/b/c/1/1.txt
                a/b/c/4/ a/b/c/5/ a/b/c/5/5.txt
                x/ x/y/ x/y/1/ x/y/2/ x/y/3/ x/y/4/ x/y/5/)],
            [qw(x/ x/y/ x/y/1/ x/y/2/ x/y/3/ x/y/4/ x/y/5/)],
            'a/b/c', 'x/y', 'example');
    }

    SKIP: {
        skip "tests" unless $tests;

        check_copy_dirs(
            [qw(a/ a/b/ a/b/1/ x/)],
            [qw(x/ x/y/ x/y/1/)], 'a/b', 'x/y', 'target dir missing');

        check_copy_dirs(
            [qw(a/ a/b/ a/b/1/ a/b/1/1.txt a/b/2/ x/ x/y/ x/y/2)],
            [qw(x/ x/y/ x/y/1/ x/y/2)], 'a/b', 'x/y', 'file exists');
        
        check_copy_dirs(
            [qw(a/ a/b/ a/b/1/ a/b/1/1.txt a/b/2/ x/ x/y/ x/y/2/)],
            [qw(x/ x/y/ x/y/1/ x/y/2/)], 'a/b', 'x/y', 'dir exists');

        check_copy_dirs(
            [qw(a.*/ a.*/b/ x/)],
            [qw(x/ x/b/)], 'a.*', 'x', 'source directory name is a regex');
	}

    done_testing;
    exit;
}

# A small test driver for copy_dirs:
# - Create a working and an expectation directory.
# - Populate the source directory tree in the working directory
# - Populate the target directory tree - at least up to the target's
#   parent directory - in the working directory.
# - Populate the expectation directory.
# - Call copy_dirs on the prepared source and target directories in the
#   working directory.
# - Compare the target directory in the working directory with the
#   expected result in the expectation directory.
#
# Arguments:
# - An array ref to a list of directories/files in the working directory
#   where copy_dirs will be called.
# - An array ref to a list of directories/files that are expected as the
#   result after copy_dirs has been called.
# - A source path within the working directory.
# - A target path within the working directory.
# - A test case title.
#
# Entries in a directory list ending with a slash are interpreted as
# directories and as plain files otherwise.  Parent directories must be
# specified and precede their content in the list.
#
# Limitations:
# There are no provisions to check for expected errors in neither phase
# of the test.
sub check_copy_dirs ($work, $expect, $source, $target, $title) {
    my $wrkdir = File::Temp->newdir();
    my $expdir = File::Temp->newdir();

    state sub populate ($wd, $content) {
        opendir my $cwd, '.';
        # Must not die in a working directory that is one of the
        # temporary directories as the clean-up could fail otherwise.
        eval {
            chdir $wd;
            m{/$} ? mkdir : open my $fh, '>', $_ for @$content;
        };
        chdir $cwd;
        die $@ if $@;
    };

    # Safely populate working and expected directories.
    eval {
        populate($wrkdir, $work);
        populate($expdir, $expect);
    };
    fail("populate: $title"), note($@), return if $@;

    # Safely call copy_dirs.
    eval {copy_dirs("$wrkdir/$source", "$wrkdir/$target")};
    fail("call: $title"), note($@), return if $@;

    # Compare the obtained with the expected result.
    ok lives {
        no warnings 'uninitialized';
        # The sub given to File::DirCompare->compare is called for
        # differing files only, i.e. it shall not be called at all.
        File::DirCompare->compare("$wrkdir/$target", "$expdir/$target",
            sub {die "@_ differing"});
    }, $title or note $@;
}
