#!/usr/bin/env perl
use strict;
use warnings;

sub title_capital{
  join ' ',map{length($_) < 3 ? lc : ucfirst lc} split ' ',$_[0];
}

printf "%s\n",title_capital('PERL IS gREAT');
printf "%s\n",title_capital('THE weekly challenge');
printf "%s\n",title_capital('YoU ARE A stAR');

