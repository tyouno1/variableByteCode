#!/usr/bin/env perl
use strict;
use warnings;
use Test::More qw/no_plan/;
use POSIX qw/floor/;

BEGIN {
    use_ok('VB');
}

is unpack('B*', vb_encode(1)),   '10000001';
is unpack('B*', vb_encode(5)),   '10000101';
is unpack('B*', vb_encode(127)), '11111111';
is unpack('B*', vb_encode(128)), '00000001' . '10000000';
is unpack('B*', vb_encode(129)), '00000001' . '10000001';

for (1..1000) {
    my $v = floor rand($_);
    is vb_decode( vb_encode($v) ), $v;
}
