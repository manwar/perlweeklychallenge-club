
  
use v5.38;

  use Graph; 
  
sub build_graph{
  my $graph = Graph->new();
  do {
      my $c = $_;
      do {
          my $r = $_;
          my($s, $t);
          ##
          # up
          ##
          $s = $r + 2;
          $t = chr(ord(qq/$c/) - 1);
          
  $graph->add_edge(qq/$c$r/, qq/$t$s/) if $s >= 1 && 
                                          $s <= 8 && 
                                          $t =~ m/[a-h]/; 

          $t = chr(ord(qq/$c/) + 1);
          
  $graph->add_edge(qq/$c$r/, qq/$t$s/) if $s >= 1 && 
                                          $s <= 8 && 
                                          $t =~ m/[a-h]/; 

          ##
          # down
          ##
          $s = $r - 2;
          $t = chr(ord(qq/$c/) - 1);
          
  $graph->add_edge(qq/$c$r/, qq/$t$s/) if $s >= 1 && 
                                          $s <= 8 && 
                                          $t =~ m/[a-h]/; 

          $t = chr(ord(qq/$c/) + 1);
          
  $graph->add_edge(qq/$c$r/, qq/$t$s/) if $s >= 1 && 
                                          $s <= 8 && 
                                          $t =~ m/[a-h]/; 

          ##
          # left
          ##
          $s = $r - 1;
          $t = chr(ord(qq/$c/) - 2);
          
  $graph->add_edge(qq/$c$r/, qq/$t$s/) if $s >= 1 && 
                                          $s <= 8 && 
                                          $t =~ m/[a-h]/; 

          $s = $r + 1;
          
  $graph->add_edge(qq/$c$r/, qq/$t$s/) if $s >= 1 && 
                                          $s <= 8 && 
                                          $t =~ m/[a-h]/; 

          ##
          # right
          ##
          $s = $r - 1;
          $t = chr(ord(qq/$c/) + 2);
          
  $graph->add_edge(qq/$c$r/, qq/$t$s/) if $s >= 1 && 
                                          $s <= 8 && 
                                          $t =~ m/[a-h]/; 

          $s = $r + 1;
          
  $graph->add_edge(qq/$c$r/, qq/$t$s/) if $s >= 1 && 
                                          $s <= 8 && 
                                          $t =~ m/[a-h]/; 

      } for 1 .. 8;
  } for q/a/ .. q/h/;
  return $graph;
}

  
  sub shortest_knight_path{
      my($graph, $start, $end) = @_;
      my @path = $graph->SP_Dijkstra($start, $end);
      say qq/$start ---> $end/;
      print @path - 1 . q/: /;
      say join q/ -> /, @path;
  }

  
MAIN:{
  my $graph = build_graph;
  shortest_knight_path($graph, q/g2/, q/a8/);
  shortest_knight_path($graph, q/g2/, q/h2/);
}  

