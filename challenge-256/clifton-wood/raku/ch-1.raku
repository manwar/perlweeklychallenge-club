sub max-pair (@words) {
  @words.classify({ ($_, .flip).sort.join }).grep( *.value > 1 ).elems;
}

<ab de ed bc       >.&max-pair.say;
<aa ba cd ed       >.&max-pair.say;
<uv qp st vu  mn pq>.&max-pair.say;
