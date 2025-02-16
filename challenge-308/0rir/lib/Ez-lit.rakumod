use v6.d;
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»

unit module Ez-lit;

=begin pod
        EXPERIMENTAL:  Names are subject to change.

I imagine these would be better as part of the quote language.

Prefix operators to ease creating numeric arrays:

    ∘< 1.0 2 3 5>     Form of 1st elem dictates Array[type] returned.  U2605

    ⊏< 1 2 3>         Array[Rat].new            U228F
    i⊏< 1 2 3>        Array[Int].new
    n⊏< 1 2 3>        Array[Num].new

=end pod

    # U2605

multi prefix:<∘>( List \a where a[0].isa(Rat) --> Array[Rat]) is export {
    Array[Rat].new( a».Rat )
}
multi prefix:<∘>( List \a where a[0].isa(Int) --> Array[Int]) is export {
    Array[Int].new( a».Int )
}
multi prefix:<∘>( List \a where a[0].isa(Num) --> Array[Num]) is export {
    Array[Num].new( a».Num ) }

    #U228F
multi prefix:<⊏>(      List \a  --> Array[Rat]) is export {
    Array[Rat].new( a».Rat )
}
multi prefix:< i⊏>( List \a  --> Array[Int]) is export {
    Array[Int].new( a».Int )
}
multi prefix:< n⊏>( List \a   --> Array[Num]) is export {
    Array[Num].new( a».Num )
}
