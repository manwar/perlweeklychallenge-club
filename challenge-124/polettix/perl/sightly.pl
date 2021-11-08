#!/usr/bin/perl
# sightly.pl.

use strict;
use Getopt::Std ();

use FindBin '$Bin';
use lib "$Bin/local/lib/perl5";
use Acme::EyeDrops qw(sightly);

sub usage
{
   print STDERR <<'EOM';
usage: sightly [-s shape] [-f file|-z string]
Options:
  -s shape        Shape/s. Can specify multiple shapes separated
                  by commas.
                  A shape is just a file with a .eye suffix,
                  so you can add new shapes yourself.
  -f file         The file to be made sightly.
  -z string       Specify a string instead of a file.
  -c string       String used with -s banner above.
  -p              Print instead of eval.
  -r [123]        Regex attribute. Insert sightly into a regex.
  -m              Use compact sightly encoding.
  -t              Pour unsightly text.
  -u textfiller   Filler for -t option.
  -U filler       FillerVar.
  -g gap          Gap between successive shapes.
  -o degree       Rotate shape 90, 180, 270 degrees.
  -a rtype        Rotate type (0, 1 or 2).
  -k              Rotate flip.
  -x bordergap    Border gap.
  -y borderwidth  Border width.
  -i              Invert shape.
  -R              Remove newlines from source text.
  -T              Add trailing spaces to output shape.
  -n gap          Indent shape gap spaces.
  -e              Reflect shape.
  -d fact         Reduce shape by a factor of fact.
  -v fact         Expand shape by a factor of fact.
  -b              Binary file.
  -w width        Width.
  -l              List available shapes.
  -E              Trap die within eval with 'die $@ if $@'
  -W              Trap warnings with '$SIG{__WARN__}=sub{}'
Examples:
  sightly -s camel -f myprog.pl >myprog2.pl
     This creates myprog2.pl, equivalent to the original
     myprog.pl, but prettier and shaped like a camel.
  sightly -p -r 1 -s window -z "Bill Gates is a pest!\n" >bill.pl
     This creates bill.pl, a program that prints the above string.
  sightly -g 3 -bps camel,mongers -f some_binary_file >eyesore
     This creates eyesore, a sightly-encoded file.
     To decode it:   perl eyesore > f.tmp
     To check it worked: cmp f.tmp some_binary_file
Notes:
  If no shape is specified, a single (very long) line will be output.
  If a shape, but no file, is specified, a default no-op filler will
  be used to fill the shape.
EOM
   exit 1;
}

sub list_shapes {
   my @builtin = Acme::EyeDrops::get_builtin_shapes();
   my @eye = Acme::EyeDrops::get_eye_shapes();
   print "builtin shapes  : @builtin\n";
   print ".eye file shapes: @eye\n";
}

my %optarg = (
   a => 'RotateType',
   b => 'Binary',
   c => 'BannerString',
   d => 'Reduce',
   e => 'Reflect',
   f => 'SourceFile',
   g => 'Gap',
   i => 'Invert',
   k => 'RotateFlip',
   m => 'Compact',
   n => 'Indent',
   o => 'Rotate',
   p => 'Print',
   r => 'Regex',
   s => 'Shape',
   t => 'Text',
   u => 'TextFiller',
   U => 'FillerVar',
   v => 'Expand',
   w => 'Width',
   x => 'BorderGap',
   y => 'BorderWidth',
   z => 'SourceString',
   E => 'TrapEvalDie',
   R => 'RemoveNewlines',
   T => 'TrailingSpaces',
   W => 'TrapWarn',
);

usage() unless @ARGV;
my %arg = (); my %option = ();
Getopt::Std::getopts("hbeiklmptERTWa:c:d:f:g:n:o:r:s:u:U:v:w:x:y:z:", \%option)
   or usage();
usage() if $option{h};
$option{l} and list_shapes(),exit(0);
$option{z} =~ s#\\n#\n#g if $option{z};
for my $k (keys %option) {
   next unless exists($option{$k});
   exists($optarg{$k}) and $arg{$optarg{$k}} = $option{$k};
}
usage() if @ARGV;
print sightly(\%arg);
