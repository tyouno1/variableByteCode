#!/usr/bin/env perl
use strict;
use warnings;
use FindBin::libs;

use VB;
use Path::Class qw/file/;

my $file = shift or die "usage: %0 <data file>\n";

my $fh = file($file)->openr;

while (my $line = $fh->getline) {
    my ($tag, $nums) = split "\t", $line;

    ## 整数列の差分を取って VB Code で符号化
    my $vb;
    my $pre = 0;
    for (split ',', $nums) {
        $vb .= vb_encode($_ - $pre);
        $pre = $_;
    }

    ## $tag, $vb の長さを pack() で付与しつつ出力
    print pack('N2', length($tag), length($vb)), $tag, $vb;
}
