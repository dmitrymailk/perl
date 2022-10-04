open my $out, '>', 'multiplication_table.txt' or die $!;
for (my $i = 1; $i <= 9; $i++) {
	for (my $j = 1; $j <= 9; $j++) {
		print $out $i * $j, "\t";
	}
	print $out "\n";
}
close $out;