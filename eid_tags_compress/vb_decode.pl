#!/usr/bin/env perl
use strict;
use warnings;
use FindBin::libs;

use VB;
use Path::Class qw/file/;

my $file = shift or die "usage: %0 <binary file>\n";

my $fh = file($file)->openr;

while (1) {
    ## タグ、VB符号部の長さを読み取る
    ## (8バイト = 32ビット + 32ビット)
    $fh->read(my $buf, 8) or last;
    my ($tlen, $vblen) = unpack('N2', $buf);

    ## 読み取った長さでタグ、VB符号部を読み取る
    $fh->read(my $tag, $tlen);
    $fh->read(my $vb, $vblen);

    ## VB Codeで復号し、差分だった値を元に戻す
    my @nums;
    my $pre = 0;
    for (vb_decode($vb)) {
        push @nums, $pre + $_;
        $pre += $_;
    }

    ## 当初のフォーマットに合わせて出力
    printf "%s\t%s\n", $tag, join ',', @nums;
}
