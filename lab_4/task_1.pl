open my $in, "<", "task_1.txt" or die "Can't open file: $!";

while (my $line = <$in>) {
	my $string = $line;
	# replace \n from string
	$string =~ s///g;

	my %hash = ();
	my @array = split ", ", $string;
	foreach my $item (@array) {
		my ($key, $value) = split ":", $item;
		$hash{$key} = $value;
	}

	# распечатать хеш
	foreach my $key (keys %hash) {
		print "$key: $hash{$key}\n";
	}
	print("\n----\n");
}
