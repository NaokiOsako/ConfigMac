#!/bin/sh

set -eu

DIR_NAME='perl-assignment-2017'

mkdir $DIR_NAME
cd $DIR_NAME

git clone git@192.218.172.56:ryuichiro.maegawa/perl-assignment.git maegawa
git clone git@192.218.172.56:imai.hayato/perl-assignment.git       imai
git clone git@192.218.172.56:Namba.Noriyuki/perl-assignment.git    namba
git clone git@192.218.172.56:Mitsuhiro.Teraoka/perl-assignment.git teraoka
git clone git@192.218.172.56:kotaro.oshima/perl-assignment.git     oshima
git clone git@192.218.172.56:Murakami.Daiki/perl-assignment.git    murakami
