use Win::VT;

unit module Win::VT::Auto;
INIT { vt-on; }
END  { vt-off; }
signal(SIGINT).tap({ vt-off; } );