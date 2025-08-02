#!/usr/bin/env perl
use v5.38;

my $ID     = qr/ (?<ID> \w+) /x;
my $FIELD  = qr/ (?<FIELD> \w+) /x;
my $NUMBER = qr/ (?<NUMBER> \d+ [ \. \d+ ]? ) /x;
my $STRING = qr/ (?<STRING> ([^"] | \\ | \\\" )+ ) /x;

my $QUOTED_STRING = qr/ (?<QUOTED_STRING> " $STRING " ) /x;
my $FIELD_VALUE = qr/ $FIELD \s* = \s* ( $NUMBER | $QUOTED_STRING ) \s* /x;
my $FIELD_VALUES = qr/ (?<FIELD_VALUES> (?: $FIELD_VALUE \s* )* ) /x;

# negative lookbehind and negative lookahead
my $TEXT = qr/ (?<TEXT> (?<! {% ) .+ (?! %} ) ) /x;
my $LINE = qr/ (?<LINE> \{% \s* $ID \s* $FIELD_VALUES \s* %\} ) /x;

my $TOP  = qr/^ (?: $LINE | $TEXT ) $/x;

my $file = shift @ARGV;
open my $fh, '<', $file;

my %data;
my @ids;
my $in_id;

while (my $line = <$fh>) {
  $line =~ /$TOP/;

  # is there a line with {% ... %} ?
  if ($+{LINE}) {
    my $id = $+{ID};
    # is the id the end of a block?
    if ($id =~ /^ end(\w+) $/x) { # capture after end
      if (exists $data{$1}) { # it is!
        $id = $1; 
        undef $in_id; # clear the id we're processing
        if ($data{$id}{'text'}) {
          # if there's text, remove the final "newline"
          $data{$id}{'text'} =~ s/\\n$//;
        }
        next; # skip to next line of file
      }
    }
    push @ids, $id; # keep list of ids in order
    $in_id = $id; # keep track of the current id for text
    # initialize base data for this id
    $data{$id} = { name => $id };
    # if we have fields...
    my $field_values = $+{FIELD_VALUES};
    # loop over field values and store them in the data
    while ($field_values =~ /$FIELD_VALUE/g) {
      my $value = $+{STRING} ? $+{STRING} : $+{NUMBER};
      if ($+{NUMBER}) {
        $value =~ s/\s+$//; # we're picking up trailing spaces
      }
      $data{$id}->{'fields'}->{ $+{FIELD} } = $value;
    }

  }
  # if we have non-{% ... %} lines and we have an ID
  elsif ($+{TEXT} && $in_id) {
    # append a "newline" to the end
    $data{$in_id}{'text'} .= $+{TEXT} . "\\n";
  }
}

use Data::Dumper::Concise;
foreach my $id (@ids) {
  print Dumper($data{$id});
}
