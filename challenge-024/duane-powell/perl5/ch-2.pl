#!/usr/bin/perl
use strict;

# Create a script to implement full text search functionality using Inverted Index.
# https://en.wikipedia.org/wiki/Search_engine_indexing#Inverted_indices

usage() unless (@ARGV);
my ($word_or_ext,@dir) = @ARGV;
my $word = $word_or_ext if (@ARGV == 1) ? $word_or_ext : "";
my $ext  = $word_or_ext if (@ARGV  > 1) ? $word_or_ext : "";

my $i = InvertedIndex->new();
if ($ext) {
	$i->build($ext,@dir);
	$i->freeze();
} elsif ($word) {
	$i->search($word);
} else {
	usage();
}
exit;

sub usage {
	my $usage = <<USAGE;
usage:
$0 word                   (return list of files containing this word)
$0 extension list-of-dirs (find new files ending in extension and index their words)
USAGE
	print $usage;
	exit;
}

package InvertedIndex;
use Storable;
use File::Find::Rule;

sub new {
        my $class = shift;
        my $self = {
		# use Storable to remember past indexing. 
		storable_index => './.inverted_index.storable',

		# unique file id counter
		file_id => 0,

		# hash ref of files  
		files => {
			# hash ref of file info
			# $file => { # full path and file name
			#	id => unique id number,
			#	mtime => file's mtime,
			# } 
		},

		# hash ref of words
		words=> {
			# hash ref of file_ids with this word
			# $word => { # lower case of actual word
			# 	file_id => count, 
			# }
		},

		# hash ref to map file_id back to file name
		ids => {
			# $id => $file
		},
	};
        bless $self, $class;

	# Reload previous self from disk
	return $self->thaw();
}

sub thaw {
        my $self = shift;
	# Retrieve the Storable object from disk and return it.
	unless (-e $self->{storable_index}) {
		# First call ever, so create the Storable. 
		print "No files have been indexed yet.\n";
		$self->freeze();
	}
	return retrieve($self->{storable_index});
}

sub freeze {
        my $self = shift;
	store $self, $self->{storable_index};
}

sub build {
        my ($self,$ext,@dir)  = @_;

	# Get list of files to index
	my @f = File::Find::Rule->file()
			   ->name( "*$ext" )
			   ->in(@dir);

	my ($file_count,$word_count) = (0,0);
	foreach my $f (@f) {
		if (open(my $FH, '<', $f)) {
			# Have we indexed this file before?
			if (exists $self->{files}{$f}) {
				# Yes but has the file been modified?
				if ($self->{files}{$f}{mtime} >= (stat $f)[9]) {
					close($FH);
					next;
				}
				# The file has been modified, delete its previous word counts
				foreach my $w (keys %{$self->{words}}) {
					delete $self->{words}{$w}{ $self->{files}{$f}{id} }; 
				}
			} else {
				# No, it's a new file, generate a unique id 
				$self->{files}{$f}{id} = $self->{file_id}++;
				$self->{ids}{ $self->{files}{$f}{id} } = $f;
			}

			# Note the file's mtime
			$self->{files}{$f}{mtime} = (stat $f)[9];
			$file_count++;

			# Parse and count words in $f 
			while (<$FH>) {
				# substitue all non-alpha-numberic chars with space then split on space
				$_ =~ s/[^a-zA-Z0-9]/ /g;
				foreach (split(/\s+/,$_)) {
					$word_count++;
					my $w = lc($_);
					$self->{words}{$w}{ $self->{files}{$f}{id} }++;
				}
			}
			close($FH);
		} else {
			 warn "Can not open $f for indexing\n";
		}
	}
	if ($file_count) {
		print "Indexed $word_count words in $file_count new files.\n";
	} else {
		print "No new files found.\n";
	}
}

sub search {
        my $self = shift;
	my $word = lc(shift);

	# Build output hash and sort by highest matching word count
	if (exists $self->{words}{$word}) {
		my %out; 
		foreach my $file_id (keys %{ $self->{words}{$word} }) {
			$out{$self->{ids}{$file_id}} = $self->{words}{$word}{$file_id};
		}
		foreach (sort { $out{$b} <=> $out{$a} } keys %out) {
			print "$out{$_} $_\n";
		}
	} else {
		print "$word not found in any of the $self->{file_id} indexed files.\n";
	}
}

1;

__END__

rm -f .inverted_index.storable <=============================================== delete Storable

./ch-2.pl <==================================================================== show usage.
usage:
./ch-2.pl word                   (return list of files containing this word)
./ch-2.pl extension list-of-dirs (find new files ending in extension and index their words)

./ch-2.pl my <================================================================= search for 'my', oops we need to index before searching.
No files have been indexed yet.

./ch-2.pl pl /home/duane/Documents/dev/perl/weekly_challenge <================= index .pl files in weekly_challenge
Indexed 6176 words in 21 new files.

./ch-2.pl my <=================================================+=============== return the count and file list with word 'my'
29 /home/duane/Documents/dev/perl/weekly_challenge/024/ch-2.pl
19 /home/duane/Documents/dev/perl/weekly_challenge/022/ch-2.pl
16 /home/duane/Documents/dev/perl/weekly_challenge/018/ch-2.pl
13 /home/duane/Documents/dev/perl/weekly_challenge/018/ch-1.pl
11 /home/duane/Documents/dev/perl/weekly_challenge/015/ch-2.pl
9 /home/duane/Documents/dev/perl/weekly_challenge/021/ch-1.pl
7 /home/duane/Documents/dev/perl/weekly_challenge/023/ch-2.pl
7 /home/duane/Documents/dev/perl/weekly_challenge/016/ch-1.pl
7 /home/duane/Documents/dev/perl/weekly_challenge/015/ch-1.pl
7 /home/duane/Documents/dev/perl/weekly_challenge/019/ch-1.pl
6 /home/duane/Documents/dev/perl/weekly_challenge/019/ch-2.pl
6 /home/duane/Documents/dev/perl/weekly_challenge/020/ch-2.pl
6 /home/duane/Documents/dev/perl/weekly_challenge/017/ch-2.pl
6 /home/duane/Documents/dev/perl/weekly_challenge/014/ch-2.pl
5 /home/duane/Documents/dev/perl/weekly_challenge/014/ch-1.pl
4 /home/duane/Documents/dev/perl/weekly_challenge/017/ch-1.pl
4 /home/duane/Documents/dev/perl/weekly_challenge/020/ch-1.pl
4 /home/duane/Documents/dev/perl/weekly_challenge/021/ch-2.pl
4 /home/duane/Documents/dev/perl/weekly_challenge/023/ch-1.pl
4 /home/duane/Documents/dev/perl/weekly_challenge/022/ch-1.pl

./ch-2.pl pl /home/duane/Documents/dev/perl/weekly_challenge_fork/ /root/bin <= index files in multiple dirs.
Indexed 391811 words in 938 new files.

./ch-2.pl pl /root/bin  <====================================================== touch file to test reindexing. 
No new files found.
touch /root/bin/pdu_control.pl
./ch-2.pl pl /root/bin
Indexed 524 words in 1 new files.

./ch-2.pl this-word-does-not-exist
this-word-does-not-exist not found in any of the 959 indexed files <=========== reports total files searched on no match.
