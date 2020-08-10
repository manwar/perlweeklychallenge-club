unit sub MAIN($S, *@A);

@A.rotor($S => -($S-1)).map(*.min).join(", ").List.say;
