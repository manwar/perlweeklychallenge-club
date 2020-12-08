{
    print length;
    gsub ("T", "x");
    gsub ("A", "T");
    gsub ("x", "A");
    gsub ("G", "y");
    gsub ("C", "G");
    gsub ("y", "C");
    print;
}
