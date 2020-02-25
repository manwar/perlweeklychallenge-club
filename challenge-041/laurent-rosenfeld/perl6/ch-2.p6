use v6

my @leo = 1, 1;
push @leo, @leo[*-1] + @leo[*-2] + 1 for 1..18;
say @leo;
