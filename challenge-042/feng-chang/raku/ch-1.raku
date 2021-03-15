#!/bin/env raku
(^51).map({ put "Decimal $_ = Octal { .base(8) }" });
