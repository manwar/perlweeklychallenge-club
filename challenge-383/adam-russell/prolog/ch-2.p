
  
  
  leading_octothorpe(Hex, Hex1):-
      nth(1, Hex, 35),
      Hex = [_|Hex1].

  
  codes_nearest_hex(Codes, Hex):-
      atom_codes(A, Codes),
      atom_concat('0x', A, A1),
      number_atom(Decimal, A1),
      N is truncate((Decimal + 25.5) / 51) * 51,
      Offset is N + 256, 
      format_to_atom(Temp, '~16R', [Offset]), 
      sub_atom(Temp, 1, 2, _, Hex).

  
  rgb(Hex, R, G, B):-
      length(R, 2),
      length(G, 2),
      length(B, 2),
      append(R, GB, Hex), 
      append(G, B, GB).

  
  nearest_rgb(R, G, B, Nearest):-
      maplist(codes_nearest_hex, [R, G, B], [R1, G1, B1]),
      atom_concat('#', R1, H1),
      atom_concat(H1, G1, H2),
      atom_concat(H2, B1, Nearest).


  
  nearest_rgb(Hex, Nearest):-
      leading_octothorpe(Hex, Hex1),
      rgb(Hex1, R, G, B),
      nearest_rgb(R, G, B, Nearest).

