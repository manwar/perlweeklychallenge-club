#! /usr/bin/env raku

unit sub MAIN (:v(:$verbose));

my $year = 2022;

say days-together({ 'Foo' => { 'SD' => '12-01', 'ED' => '20-01' },
                    'Bar' => { 'SD' => '15-01', 'ED' => '18-01' }});


say days-together({ 'Foo' => { 'SD' => '02-03', 'ED' => '12-03' },
                    'Bar' => { 'SD' => '13-03', 'ED' => '14-03' }});


say days-together({ 'Foo' => { 'SD' => '02-03', 'ED' => '12-03' },
                    'Bar' => { 'SD' => '11-03', 'ED' => '15-03' }});

say days-together({ 'Foo' => { 'SD' => '30-03', 'ED' => '05-04' },
                    'Bar' => { 'SD' => '28-03', 'ED' => '02-04' }});


sub days-together ($struct)
{
  my $sf = Date.new($year ~ "-" ~ $struct<Foo>.<SD>.split("-").reverse.join("-")).day-of-year;
  my $ef = Date.new($year ~ "-" ~ $struct<Foo>.<ED>.split("-").reverse.join("-")).day-of-year;
  my $sb = Date.new($year ~ "-" ~ $struct<Bar>.<SD>.split("-").reverse.join("-")).day-of-year;
  my $eb = Date.new($year ~ "-" ~ $struct<Bar>.<ED>.split("-").reverse.join("-")).day-of-year;

  say ": $sf, $ef, $sb, $eb" if $verbose;

  return 0 if $sf > $eb;
  return 0 if $sb > $ef;

  my $start = max($sf, $sb);
  my $end   = min($ef, $eb);

  return $end - $start + 1;
}

