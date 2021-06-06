#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

my @examples = (
  [ [qw(abc dea cd)], 1],
  [ [qw(ade cbd fgh)], 0 ],
  [ [qw(ab bc ca de ef fd)], 0 ],
  [ [qw(ab bc ca ae)], 0 ],
  [ [qw(bad bed bid bod bud dub dob dib deb dab)], 1 ],
  [ [qw(abc def fed)], 0 ],
  [ [qw(ana)], 1 ],
  [ [qw(ana bob)], 0 ],
  [ [qw(ana one ant glo ten era nag )], 1 ],
  [ [qw(ana bad bed dab deb)], 0 ],
  [ [qw(bad bed ana dab deb)], 0 ],
  [ [qw(abc cde efg ghi ijk kla cpq qpc eft the ilm mli)], 1 ],
#); @examples = (
  [ [qw(pk fz iy oz cf xm gm uy ur te ct zz rw jm aq oq xy mi me rv jc iv sx pq lz nd cm vj uf rq ij zk ef wm bb cj vv oo og ft fq mj os uh gn ml mz fm az yr zh wa bm gj xn df yf er xc xb bl uw ri nq nn oi pc ym jr da rz bq vm sr ni jz po oj wf iu ja tu lk yt nc sl wi zb hm uv th kn hk pv yq ez we im gt za sj nh qr bt rr ok ai xx qs lg ue fc ws vc vy ki xi wy fv lt rl xw nj gu dz ip zl je pf hn uk di mv ug vf uz wt yn qx rh sz fh pm sa qz gp gw jp ve le fe ia nw pu km uo gy li pe hj mn ew hg qg se mq by vh ca hd bn nl xu dd ji bd ol vp wp yo st ac bh bx fa md zx mm ox qi mc lc jx wz jd xt vr yj pn uj zy ih ul pb id xh wb qq xg ou sp bo yz bu ec vz fy io hl jo cl zs ge tz qp mf zf kq sk qw as vs rm jw yk tr cw tk xz kt ra qo tj fu dy hx ic ej nt jt gf ko rd od ep qn sg ek ui bg iw zm at dv fx kb xr nu xl xs lr xk na ne xe rt jf ga hv kf xq sq pt cp rj fr fp qf gg ii ey tn ce ya kl wc ks qh em gc ts dn wk is fo pa sd ly uc zn dk wq bw tq kg xf vn ea hh ik lm nr wd kc mu ru co kx nb gl fs bi hu fk ld qa qy qm wl cn cr zd ke jl gz wr xp tm tl kj no ex wj su dc sh ee hf dw ax ms hq jj sb ed qj vw ha ju wx yi sf ln jy rx ei sy ar dm hr al ah mb on ob uq ps lv ad jk rb fb gk cc rp jq ka my ix nv re vk tp zw rg tb up pp uu ds ho zv nf ty cu kp eg in lu hy mk um zt hc qt yp tv rk hb pj ph bk af to lq qe ib gi bz jh iz lo yv ci jg gh yx bj il cz gx ro ff kk vd ub et bs tw si qd ql au ti xj yh yl kr om nx lw wo gs gq ku mw py tx ll fl xd ch rc go dt lx zu ry hz bc lj la lh ux sc fn it ir tt mo pr gd sm mx jn cd vl vb mt pz vt he eh ss dh dj yw xv be ov wh ww pg ao es ye xa vq hs yc yd vu ns zr lf rs pl cs eo zi qb qk so oc wn el zc yb de mg fw cx cv wv ot cb qu wu nm ow zp rn hw lp ma en vg cy rf tc am ut cq sv kv oh jb np us ck mh ny gr gb op an kw aa vo zq iq ba px dr un or ze bp zg eb ud if dl dq zj ky bf vi cg ua br yu mp bv sn pi db ae of kh pd hp qc jv xo du fg ta do kd dx av ys tg ls fi kz tf eu aj sw vx oa pw fd ab hi va lb dg ig dp nz js qv ag aw eq mr zo yy ie nk yg ap oe gv oy ht ev ak td ay fj ng wg)], 1 ],
);

is(circ_single_connected(@{$_->[0]}),$_->[1]) foreach @examples;
is(circ_single(@{$_->[0]}),$_->[1])   foreach @examples;

done_testing();
cmpthese( 400, {
  nr => sub { circ_single_connected(@{$_->[0]}) foreach @examples; },
  r  => sub { circ_single(@{$_->[0]}) foreach @examples; },
} );

sub circ_single_connected {
  my(%F,%ends);

  ## %F    contains the number of starts - number of ends...
  ## %ends contains a hash of hashes - first key is the first letter of the world,
  ##                                   2nd level end of the world.

  ( $F{ substr $_, 0, 1 }++, $F{    substr $_, -1   }-- ) foreach @_;
  ## Rule out those that cannot be connected in loop....
  return 0 if grep {$_} values %F; ## This quickly filters out those cases in which we
                                   ## can't join end on end... now there is a harder
                                   ## problem coming up which is to work out if there
                                   ## is a multi-loop option

  ## Now we have to see if we have connectivity...
  ## Take any (the first) element...

  $ends{ substr $_, 0, 1 }{ substr $_, -1 }++ foreach @_;
  my @seeds = [keys %ends]->[0];

  while(@seeds) { ## If we have any seeds then we
    ## Remove the information about ends from the list for each
    ## letter in the seed list.. (start words)
    ## For each of these we collect the end letters (using a hash
    ## to uniqueify them)
    my %x  = map { $_ => 1 }
             map { keys %{ delete $ends{$_} } }
             @seeds;
    ## We then remove any letters which we have already processed
    ## {i.e. those that have already been removed from %ends}
    @seeds = grep { exists $ends{$_} } keys %x;
  }
  ## If we have stuff left it ends there will be 2 or more connected loops.
  return keys %ends ? 0 : 1;
  ## Now we start at any point and get the first circle....
}

sub circ_single_connected_nc {
  my( %F, %ends );
  ( $F{ substr $_, 0, 1 }++, $F{    substr $_, -1   }-- ) foreach @_;
  return 0 if grep {$_} values %F;

  $ends{ substr $_, 0, 1 }{ substr $_, -1 }=1 foreach @_;
  my @seeds = [keys %ends]->[0];
  while(@seeds) {
    my %x   = map { $_ => 1 }
              map { keys %{ delete $ends{$_} } }
              @seeds;
    @seeds  = grep { exists $ends{$_} } keys %x;
  }
  return keys %ends ? 0 : 1;
}

sub circ_single {
no warnings 'recursion'; ## Disable deep recursion warning - this gets messy...
  my @words = @_;
  my %F;
  ($F{substr$_,0,1}++,$F{substr$_,-1}--) foreach @words;
  return 0 if grep {$_} values %F; ## This quickly filters out those cases in which we
                                   ## can't join end on end... now there is a harder
                                   ## problem coming up which is to work out if there
                                   ## is a multi-loop option
                                   ## e.g. "ab","bc","ca","de","ef","fd" - which
                                   ## can't make a single loop...
  ## Special case where we have 1 word and it starts/ends with the same letter!
  return 1 if @words ==1;

  ## nested sub-function which does the exhaustive/recurisve search for a single
  ## "circle"... look through all routes....
  sub exhaust {
    my ($init,@words) = @_;
    my $n = @words;
    ## If we have just two "words" then check that they form a loop.
    if( $n==1) {
      return substr($init,-1)  eq substr($words[0],0,1)
          && substr($init,0,1) eq substr($words[0],-1)  ? 1 : 0;
    }
    ## o/w we loop through the list of words...
    ## if the start of one word matches the end of the "first word"
    ## then we "extend" the first word, and repeat recursively,
    ## returning 1 if we eventually reach the criteria above...
    foreach(1..$n) {
      push @words,shift @words;
      next unless (substr $init,-1) eq substr $words[0],0,1;
      return 1 if exhaust( $init.$words[0], @words[1..($n-1)] );
    }
    ## In none match criteria we return 0...
    return 0;
  }

  return exhaust( @words );
  use warnings 'recursion';
}

