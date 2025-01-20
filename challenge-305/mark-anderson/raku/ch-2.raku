#!/usr/bin/env raku
use Test;

is-deeply alien-dictionary(<perl python raku>,
                           <h l a b y d e f g i r k m n o p q j s t u v w x c z>),
                           <raku python perl>;

is-deeply alien-dictionary(<the weekly challenge>,
                           <c o r l d a b t e f g h i j k m n p q s w u v x y z>),
                           <challenge the weekly>;

sub alien-dictionary(@words, @alien)
{
    @words.sort({ .trans('a'..'z' => @alien) })
}
