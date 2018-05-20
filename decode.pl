#!/usr/bin/perl
use strict;
use warnings;

while(<>){
        chomp;
        my $pre =0;
        my @result;
        foreach my $c (decode($_)) {
                push @result, $pre+$c;
                $pre += $c;
        }
        print join ("," ,@result) ,"\n";
}

sub decode {
	my $stream = shift;
	my $n = 0;
	my @arr;
	foreach my $c ( unpack('C*',$stream) ){
		if ($c < 128){
			$n = 128 * $n + $c;
		}else{
			push @arr,128*$n + ($c-128);
			$n = 0;
		}
	}
	return wantarray? @arr : $arr[0]; #根据调用的环境，决定返回数组还是标量
}
