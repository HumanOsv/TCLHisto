#!/usr/bin/perl
use warnings;
use strict;

#
sub read_cart_file{
	my ($input_file)=@_;
	my @data=();
	open(FILE, "<", $input_file) or die "Can't open";
	my @lines=<FILE>;
	close(FILE);
	foreach my $i (@lines){
		chomp($i);
		$data[++$#data]=$i;
	}
	return @data;
}

#
#
#
my ($file) = @ARGV;
if (not defined $file) {
	die "\nHisto must be run with:\n\nUsage:\n\tHisto.pl [data]\n";
	exit(1);
}
#
# read and parse
my @data       = read_cart_file($file);
#
my %InfoValues = ();
#
foreach my $i (@data) {
	my @tmp = split (' ',$i);
	foreach my $element ( @tmp ) {
		++$InfoValues{$element};
	}
}
#
my @fruits = keys %InfoValues;
my @nums   = sort { $a cmp $b } @fruits;
#
print "Resid\tFreq\n";
for my $count (@nums) {
	if ($InfoValues{$count} > 0) {
    		print "$count\t$InfoValues{$count}\n";
	}
}
