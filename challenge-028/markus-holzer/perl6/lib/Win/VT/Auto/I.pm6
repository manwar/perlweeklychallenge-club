use Win::VT;

unit module Win::VT::Auto::I;
INIT { vt-on( :vt-output(False) ) }
END  { vt-off; }
signal(SIGINT).tap({ vt-off; } );