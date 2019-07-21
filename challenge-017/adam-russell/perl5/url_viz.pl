use GraphViz::Parse::Yapp;

# Pass in a file generated via yapp -v
my $g = GraphViz::Parse::Yapp->new("perl5/UrlGrammar.output");
print $g->as_png;
