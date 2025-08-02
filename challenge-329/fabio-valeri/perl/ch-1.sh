perl -E 'my %seen; say join ", ", grep !$seen{$_}++, shift=~/\d+/g' "the1weekly2challenge2"
