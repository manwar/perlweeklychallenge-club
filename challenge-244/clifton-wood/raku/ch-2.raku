my @a = (2, 1, 4); my @b = do gather for 1..@a.elems {
    take $_ for @a.combinations($_)
};
@b .= map({ .min * .max² });
say "{ @b.gist }:{ @b.sum }"
