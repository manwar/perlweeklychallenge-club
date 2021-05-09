#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Given a word, you can sort its letters alphabetically (case insensitive). For example, "beekeeper" becomes "beeeeekpr" and "dictionary" becomes "acdiinorty". Write a script to find the longest English words that don't change when their letters are sorted.
=cut











use File::Basename;
use Mojo::UserAgent;
use URI;
use FindBin qw($Bin);


# Download dictionary if it was not downloaded yet.

unless ( (-e "$Bin/words.txt") and (-s "$Bin/words.txt" > 5_000_000) )
{
     my $url = URI->new( 'https://github.com/dwyl/english-words/raw/master/words.txt' );
     my $file = basename( $url->path );
     my $response = Mojo::UserAgent->new->max_redirects(5)->get( $url->as_string )->res;
     die "Error while downloading a dictionary file!$/" unless 200 == $response->code;
     open my $fh, '>', "$Bin/$file" or die "$!";
     print {$fh} $response->body;
}





my $max_len = 0;
my $candidate = '';
open my $in, "<", "$Bin/words.txt" or die "$!";

LINE: while ( my $line = <$in> )
{
     chomp $line;
     my $this_len = length($line);

     next if $this_len < $max_len;
     $line = lc $line;
     
     for my $i ( 1 .. $this_len)
     {
          my $substring = substr($line, 0, $i);
          my $sorted =  join('', sort {$a cmp $b} split(//,$substring));
          next LINE if $substring ne $sorted;

     }
     $candidate = $line;
     $max_len = length($line);
}

print $candidate, $/;