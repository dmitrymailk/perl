open my $in, '<', 'numbers.txt' or die $!;
open my $out, '>', 'sums.txt' or die $!;
while (my $line = <$in>) {
	chomp $line;
	my @numbers = split "\t", $line;
	my $sum = 0;
	
	foreach my $number (@numbers) {
		$sum += $number;
	}
	print $out $sum, "\n";
}
close $in;
close $out;