#! /usr/bin/env raku

unit sub MAIN ($source where $source.substr(0,1) eq '/' && $source.IO.e && $source.IO.d = '/tmp/a/b/c',
               $target where $target.substr(0,1) eq '/' && $target.IO.e && $target.IO.d = '/tmp/x/y',
	       :d(:$dryrun),
	       :v(:$verbose) = $dryrun);

indir($source, { do-dir(".") });

sub do-dir ($dir)
{
  for dir($dir).sort -> $file
  {
    next unless $file.d;
    say ": mkdir $target/$file { $dryrun ?? ' [Dryrun]' !! '' }" if $verbose;
    mkdir "$target/$file" unless $dryrun && "$target/$file".IO.e;
    do-dir($file);
  }
}
