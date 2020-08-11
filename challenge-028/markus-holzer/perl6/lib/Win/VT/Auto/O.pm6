use Win::VT;

unit module Win::VT::Auto::O;
INIT { vt-on( :vt-input(False) ) }
END  { vt-off; }
signal(SIGINT).tap({ vt-off; } );


