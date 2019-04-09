# Awesome alphabetic assertions introduced in 5.28, they are experimental,
# so I use -X to suppress warnings ("Extended Patterns" in perlre).
#
# \b - word boundary
#
# /e flag stands for "eval", simple example:
#
# perl -E' $f = 41; $f =~ s/.*/$& + 1/e; say $f'
#
# See all of the above in perlre, interpreter arguments described in perlrun

perl -M5.028 -Xpe 's/ (*negative_lookbehind:\.) \b\d+\b / 0 + $& /egx'

# or shorter form, which I prefer:
# perl -Xpe 's/ (*nlb:\.) \b\d+\b / 0 + $& /egx'

# if we don't care about decimal point:
# perl -Xpe 's/\b\d+\b/0+$&/eg'
