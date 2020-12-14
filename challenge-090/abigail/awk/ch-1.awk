{
    print length;
    gsub ("A", "x");
    gsub ("T", "A");
    gsub ("x", "T");
    gsub ("G", "y");
    gsub ("C", "G");
    gsub ("y", "C");
    print;
}
