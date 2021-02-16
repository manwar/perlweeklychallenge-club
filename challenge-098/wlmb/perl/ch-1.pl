#!/usr/bin/env perl
# Perl weekly challenge 098
# Task 1: Read N characters
#
# See https://wlmb.github.io/2021/02/01/PWC098/#task-1-read-n-characters
use warnings;
use strict;
use v5.12;
use Scalar::Util qw(looks_like_number);
use List::Util qw(all);

sub readN { # find and call the appropriate reader with the appropriate argument
    my $filename=shift;
    my $number=shift;
    return reader($filename)->($number); #get the appropriate reader to read
}


sub reader { #returns a reader, maybe creating it.
    state %reader; #hash of readers, one per seen filename
    my $filename=shift;
    $reader{$filename} //=new_reader($filename);
}

sub new_reader {#create a new reader
    my $filename=shift;
    open my $fh, "<", $filename or die "Couldn't open $filename: $!";
    my $line=""; #plays the role of a buffer
    my $reader= sub { #This is the actual reader routine
	my $number=shift;
	while($number>length($line)){ #get enough characters
	    my $nextline=<$fh>;
	    last unless $nextline;
	    #I remove newlines. If not desired, comment the next line
	    chomp($nextline);
	    $line .= $nextline;
	}
	my $result=substr $line,0,$number;
	(substr $line,0,$number)='';
	return $result;
    }
}

usage() unless @ARGV%2==0;
usage() unless all {looks_like_number($ARGV[$_]) && $ARGV[$_]>=1}, map {2*$_+1} 0..(@ARGV-1)/2;
my $res; # Don't print empty lines after file is consumed
say $res while(@ARGV and $res=readN(shift @ARGV, shift @ARGV));
sub usage {
    say <<'END';
    ./ch-1.pl file1 N1 file2 N2 ...
    Reads N1 chars from file1, N2 from file2 and so on.
    Filenames may repeat
END
}
