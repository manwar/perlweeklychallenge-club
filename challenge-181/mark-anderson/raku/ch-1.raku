#!/usr/bin/env raku
use Text::Wrap;

say wrap-text('paragraph.txt'.IO.slurp
                                .trans(/\n/ => ' ')
                                .split('.')
                                .map({ .words.sort(*.lc) })
                                .join('. '), :width(60));
