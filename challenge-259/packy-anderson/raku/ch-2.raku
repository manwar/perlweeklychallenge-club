#!/usr/bin/env raku
use v6;

grammar Parser {
  rule TOP { [ <line> | <text> ] }

  rule line { '{%' <id> [ <field-value> ]* '%}' }

  # negative lookbehind and negative lookahead
  rule text { <!after ｢{%｣ > <-[ \n ]>+ <!before ｢%}｣ >}

  token id    { \w+ }
  token field { \w+ }

  token number { \d+ [ \. \d+ ]? }

  token quoted-string { '"' <string> '"' }
  token string {
    [
      <-[ " ]> # any character not a quote
      |
      ｢\\｣     # an escaped backslash
      |
      \\\"     # an escaped quote
    ]*
    }
  
  rule field-value { <field> '=' [<number> | <quoted-string>] }
}

sub MAIN($file) {
  my %data;
  my @ids;
  my $in_id = '';
  for $file.IO.lines -> $line {
    # parse this line of the file
    my $p = Parser.parse($line);

    # is there a line with {% ... %} ?
    if ($p<line>) {
      my $id = $p<line><id>.Str;
      # is the id the end of a block?
      if (my $c = ($id ~~ / end(\w+) /)) { # capture after end
        if (%data{$c[0]}:exists) { # it is!
          $id = $c[0]; 
          $in_id = ''; # clear the id we're processing
          if (%data{$id}{'text'}) {
            # if there's text, remove the final "newline"
            %data{$id}{'text'} ~~ s/\\n$//;
          }
          next; # skip to next line of file
        }
      }
      @ids.push($id); # keep list of ids in order
      $in_id = $id; # keep track of the current id for text
      # initialize base data for this id
      %data{$id} = { name => $id };
      # if we have fields...
      if ($p<line><field-value>) {
        # loop over them and store them in the data
        for $p<line><field-value> -> $fv {
          my $field = $fv<field>;
          my $value = $fv<number> ?? $fv<number> 
                   !! $fv<quoted-string><string>;
          %data{$id}{'fields'}{$field} = $value;
        }
      }
    }
    # if we have non-{% ... %} lines and we have an ID
    elsif ($p<text> && $in_id) {
      # append a "newline" to the end
      %data{$in_id}{'text'} ~= $p<text> ~ "\\n";
    }
  }

  # dump the data
  for @ids -> $id {
    my %group = %data{$id};
    say "\{";
    say "  name => %group{'name'},";
    say "  fields => \{";
    for %group{'fields'}.keys.sort -> $k {
      say "    $k => %group{'fields'}{$k},";
    }
    say "  }";
    say "  text => %group{'text'}" if %group{'text'};
    say "\}";
  }
}
