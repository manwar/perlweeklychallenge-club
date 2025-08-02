
  
  common_elements(L0, L1, Common):-
      maplist(common_element(L0), L1, C0),
      sort(C0, C1),
      delete(C1, nil, Common).
  common_element(L, X, X):-
      member(X, L).
  common_element(L, X, nil):-
      \+ member(X, L).

  
  intersections(Lists, Intersections):-
      intersections(Lists, [], Intersections).
  intersections([H0, H1|[]], [], Intersections):-
      common_elements(H0, H1, Intersections).        
  intersections([H0, H1|[]], IntersectionsAccum, Intersections):-
      common_elements(H0, H1, Common),
      common_elements(Common, IntersectionsAccum, Intersections).
  intersections([H0, H1|T], IntersectionsAccum, Intersections):-
      common_elements(H0, H1, Common),
      append(IntersectionsAccum, Common, I),
      intersections([Common|T], I, Intersections).

