#!//bin/sh

perl -E 'say q{(},(join q{, },map{split//}@ARGV),q{)}' "$@"
