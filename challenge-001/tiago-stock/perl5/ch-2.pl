print
    !($_%15) ? 'fizz buzz' :
    !($_%3)  ? 'fizz' :
    !($_%5)  ? 'buzz' : $_ ,
    "\n" for (1 .. 20);
