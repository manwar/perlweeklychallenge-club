# See README for analysis common to Perl and Raku.

# Technical definition from the task.
sub is_Cardano_triplet ( (\a,\b,\c) --> Bool ) {
    sub cbrt (\n) { n.sign  *  n.abs ** ⅓ }

    my \bsc = b * sqrt(c);
    return 1e-14 > abs( cbrt(a + bsc) + cbrt(a - bsc) - 1 );
}

# Given (A,B), solve for C, and return all three if C is integer.
sub find_Cardano_triplet ( (\a, \b) ) {
    my Rat \c = (a + 1)² * (8*a - 1) / (27 * b²);
    return (a, b, c.narrow) if c.denominator == 1;
}

# My own algorithm for efficient lazy infinite N-tuples.
# May be a module someday, or at least a blog post.
sub triplet_generator ( ) {
    return lazy gather for 1..* -> $limit {
        my @inner = 1 ..^ $limit;

        # 3 outer planes minus the edges, then the 3 edges, then the corner.
        .take for @inner X @inner X $limit;
        .take for @inner X $limit X @inner;
        .take for $limit X @inner X @inner;

        .take for $limit X $limit X @inner;
        .take for $limit X @inner X $limit;
        .take for @inner X $limit X $limit;

        .take for $limit X $limit X $limit;
    }
}

constant @fixed_X_triplets = [X] (1..21) xx 3;
constant @fixed_X_doublets = [X] (1..21) xx 2;

my @answers =
    triplet_generator().grep( &is_Cardano_triplet), # Small 3-tuples, no bias
      @fixed_X_triplets.grep( &is_Cardano_triplet), # Small 3-tuples, left-biased, c-range-limit forces higher a&b
      @fixed_X_doublets.map(&find_Cardano_triplet), # Small 2-tuples, left-biased, unlimited range for `c`
                 (^Inf).map({find_Cardano_triplet( (3 * $_ + 2,  1), )}), # Force b=1
;

say .head(5)».fmt('%3d') for @answers;
