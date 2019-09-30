sub MAIN( $file )
{
    my $magic = run( "file", $file, :out ).out.slurp;
    say "The file content is ", ($magic ~~ / \s text \, / ?? "ascii" !! "binary");
}
