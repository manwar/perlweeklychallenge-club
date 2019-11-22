my role X::Morse is Exception {
  has $.payload;
  method message { 'Morse error' }
}

my class X::Morse::UnknownCharacter does X::Morse {
  method message { "Character code not recognized: $!payload" }
}

my class X::Morse::InvalidSequence does X::Morse {
  method message { 'Bit sequence could not be parsed' }
}

module Morse {
  my constant %values = (
    :A(0b10111),         :B(0b111010101),
    :C(0b11101011101),   :D(0b1110101),
    :E(0b1),             :F(0b101011101),
    :G(0b111011101),     :H(0b1010101),
    :I(0b101),           :J(0b1011101110111),
    :K(0b111010111),     :L(0b101110101),
    :M(0b1110111),       :N(0b11101),
    :O(0b11101110111),   :P(0b10111011101),
    :Q(0b1110111010111), :R(0b1011101),
    :S(0b10101),         :T(0b111),
    :U(0b1010111),       :V(0b101010111),
    :W(0b101110111),     :X(0b11101010111),
    :Y(0b1110101110111), :Z(0b11101110101),
    1 => 0b10111011101110111,
    2 => 0b101011101110111,
    3 => 0b1010101110111,
    4 => 0b10101010111,
    5 => 0b101010101,
    6 => 0b11101010101,
    7 => 0b1110111010101,
    8 => 0b111011101110101,
    9 => 0b11101110111011101,
    0 => 0b1110111011101110111,
    ｢.｣ => 0b10111010111010111,
    ｢,｣ => 0b1110111010101110111,
    ｢?｣ => 0b101011101110101,
    ｢'｣ => 0b1011101110111011101, #'
    ｢!｣ => 0b1110101110101110111,
    ｢/｣ => 0b1110101011101,
    ｢(｣ => 0b111010111011101,
    ｢)｣ => 0b1110101110111010111,
    ｢&｣ => 0b10111010101,
    ｢:｣ => 0b11101110111010101,
    ｢;｣ => 0b11101011101011101,
    ｢=｣ => 0b1110101010111,
    ｢+｣ => 0b1011101011101,
    ｢-｣ => 0b111010101010111,
    ｢_｣ => 0b10101110111010111,
    ｢"｣ => 0b101110101011101, #"
    ｢$｣ => 0b10101011101010111,
    ｢@｣ => 0b10111011101011101,
  );
  my constant %chars = %values.antipairs;

  grammar Decode {
    token TOP  { <word>+ % '0' ** 7 }
    token word { <char>+ % '000' }
    token char { <mark>+ % '0' }
    proto token mark {*}
          token mark:sym<dot>  { '1' }
          token mark:sym<dash> { '111' }
  }

  class Decoder {
    method TOP ($/) {
      make $<word>.map(*.made).join(' ');
    }

    method word ($/) {
      make $<char>.map(*.made).join;
    }

    method char ($/) {
      make %chars{ $/.Str.parse-base(2) }
        or X::Morse::UnknownCharacter.new(
          :payload( $<mark>.map(*.made).join ~ ' | ' ~ $/ )
        ).throw;
    }

    method mark:sym<dot>  ($/) { make '.' }
    method mark:sym<dash> ($/) { make '-' }
  }

  #| Decode binary morse code
  sub decode (
    Str $bits where *.comb(/\S/).all eq 1|0, #= A string containing a sequence of 1s and 0s
    --> Str
  ) is export {
    .return with Decode.parse(
      $bits.trans( /\s+/ => '' ),
      :actions(Decoder.new)
    ).made;
    X::Morse::InvalidSequence.new.throw;
  }

  #| Encode binary morse code
  sub encode (
    Str $phrase,
    --> Str
  ) is export {
    $phrase.uc.comb(/\S+/)
      .map(*.comb)
      .deepmap({ .base(2) with %values{$_} })
      .map(*.grep(*.defined).join('000'))
      .join('0' x 7);
  }
}
