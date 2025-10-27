#import "parrot.h"

auto check_order(auto ints) { //
  return ints.sort().neq(ints).where() - 1;
}