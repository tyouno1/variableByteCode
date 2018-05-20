package VB;
use strict;
use warnings;
use integer;

use Exporter::Lite;

our @EXPORT = qw/vb_encode vb_decode/;

sub vb_encode {
    my $n = shift;
    my @bytes;
    while (1) {
        unshift @bytes, $n % 128;
        if ($n < 128) {
            last;
        }
        $n = $n / 128;
    }
    $bytes[-1] += 128;
    return pack('C*', @bytes);
}

sub vb_decode {
    my $vb = shift;
    my $n = 0;
    my @nums;
    for my $c (unpack('C*', $vb)) {
        if ($c < 128) {
            $n = 128 * $n + $c;
        }
        else {
            push @nums, 128 * $n + ($c - 128);
            $n = 0;
        }
    }
    return wantarray ? @nums : $nums[0];
}

1;
