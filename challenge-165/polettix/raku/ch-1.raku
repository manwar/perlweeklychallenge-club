#!/usr/bin/env raku
use v6;
sub MAIN (Str $input = "53,10\n53,10,23,30\n23,30") {
   put svg-for($input)
}

sub svg-for ($input) {
   (
      gather {
         take '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">';
         take open-tag('svg', width => 400, height => 400, xmlns => 'http://www.w3.org/2000/svg');
         for $input.lines -> $line {
            my @nums = $line.split(/ \, /);
            take @nums == 2 ?? point(@nums) !! line(@nums);
         };
         take close-tag('svg');
      }
   ).join("\n");
}

sub open-tag ($tag, *%args) {
   ("<$tag", %args.kv.map(-> $k, $v {qq<$k="$v">}), '>').join(' ');
}

sub oneshot-tag ($tag, *%args) {
   ("<$tag", %args.kv.map(-> $k, $v {qq<$k="$v">}), '/>').join(' ');
}

sub close-tag ($tag) { return "</$tag>" }

sub point (@p, *%args) {
   my %pargs =
      'cx', @p[0],
      'cy', @p[1],
      'r', 4,
      'stroke-width', 0,
      'fill', '#000000'
      ;
   oneshot-tag('circle', |%pargs, |%args);
}

sub line (@ps, *%args) {
   my %pargs =
      'points', @ps.join(' '),
      'stroke-width', 6,
      'stroke', '#ff0000';
   oneshot-tag('polyline', |%pargs, |%args);
}
