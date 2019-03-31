# throws
# Modification of a read-only value attempted at -e line 1.
perl -E '$,=","; say map { $_, tr/e/E/ } "Perl Weekly Challenge" x 1'

perl -E 'say for map { $_, tr/e/E/ } "Perl Weekly Challenge" x 1'
