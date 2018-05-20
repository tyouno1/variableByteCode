#!/usr/bin/perl
use strict;
use warnings;
use integer;

while(<>){
        chomp;
        my $pre = 0;
        my $output;
        foreach my $num ( split ',',$_ ){
                $output .= encode($num-$pre);
                $pre = $num;
        }
        #print $output."\n";
}

sub encode {
	my $num = shift;
	my @bytes;

	while (1) {
        unshift @bytes, $num % 128;
        last if ($num < 128);
        $num = $num/128;
	}
    print $num."\n";
	$bytes[-1] += 128; #add 1 sign to the last byte(8 bits)
	return pack('C*',@bytes);
}
