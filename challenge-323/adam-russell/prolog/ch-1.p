
  
  increment_variable(X, U, V):-
      member(X-I, U),
      delete(U, X-I, U1),
      I1 is I + 1,
      append([X-I1], U1, V).
  increment_variable(X, U, V):-
      \+ member(X-_, U),
      append([X-1], U, V).
  decrement_variable(X, U, V):-
      member(X-I, U),
      delete(U, X-I, U1),
      I1 is I - 1,
      append([X-I1], U1, V).
  decrement_variable(X, U, V):-
      \+ member(X-_, U),
      append([X-(-1)], U, V).
  declare_variable(X, U, V):-
      delete(U, X-_, U1),
      append([X-0], U1, V).

  
  variables(VariableState), [VariableState] --> [VariableState].
  variables(V, VariableState), [VariableState] --> [V].

  
  process(Input) --> variables(V, VariableState),
                     {Input = [Code1, Code2, Code3 | Codes],
                      Code1 == 43, Code2 == 43, Code3 >= 97, 
                      Code3 =< 122, 
                      increment_variable(Code3, V, VariableState)},
                      process(Codes).
  process(Input) --> variables(V, VariableState),
                     {Input = [Code1, Code2, Code3 | Codes],
                      Code2 == 43, Code3 == 43, Code1 >= 97, 
                      Code1 =< 122, 
                      increment_variable(Code1, V, VariableState)},
                      process(Codes).
  process(Input) --> variables(V, VariableState),
                     {Input = [Code1, Code2, Code3 | Codes],
                      Code1 == 45, Code2 == 45, Code3 >= 97, 
                      Code3 =< 122, 
                      decrement_variable(Code3, V, VariableState)},
                      process(Codes).
  process(Input) --> variables(V, VariableState),
                     {Input = [Code1, Code2, Code3 | Codes],
                      Code2 == 45, Code3 == 45, Code1 >= 97, 
                      Code1 =< 122, 
                      decrement_variable(Code1, V, VariableState)},
                      process(Codes).
  process(Input) --> variables(V, VariableState),
                     {Input = [Code | Codes],
                      Code >= 97, Code =< 122,
                      declare_variable(Code, V, VariableState)},
                      process(Codes).
  process(Input) --> {Input = [Code | Codes],
                      Code == 32},
                      process(Codes).
  process([]) --> [].

  
  show_variables(X-I):-
      atom_codes(A, [X]),
      write(A),
      write(': '),
      write(I), nl.

  
  increment_decrement(Input):-
      phrase(process(Input), [[]], [Output]), !,
      maplist(show_variables, Output).

