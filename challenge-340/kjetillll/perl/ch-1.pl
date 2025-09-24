sub f { $_[0] =~ /(.)\1/ ? f( $` . $' ) : pop }

print f('abbaca')   eq 'ca' ? "ok\n" : "error\n";
print f('azxxzy')   eq 'ay' ? "ok\n" : "error\n";
print f('aaaaaaaa') eq ''   ? "ok\n" : "error\n";
print f('aabccba')  eq 'a'  ? "ok\n" : "error\n";
print f('abcddcba') eq ''   ? "ok\n" : "error\n";
