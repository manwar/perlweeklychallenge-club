perl -E 'say join " ",split /(?<=(.))(?!\1)/,scalar ABBCDEEF'
