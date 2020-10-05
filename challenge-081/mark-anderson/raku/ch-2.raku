unit sub MAIN($file);

say freq-sort($file).join("\n\n");

sub freq-sort($file) {
    my %h;

    %h{$_}++ for $file.IO.slurp andthen S:g/<[."(),]>|\'s|\-\-/ /.words;

    gather take "{.key} {.value.sort}" 
                              for %h.classify({.value}, :as{.key}).sort;
}
