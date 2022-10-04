use open qw(:utf8);
binmode STDOUT,':utf8';

open my $in, "<", "task_2.txt" or die "Can't open file: $!";
my %hash = ();

while (my $line = <$in>) {
	my $string = $line;
	# replace \n from string
	$string =~ s///g;

	my @array = split " ", $string;
	foreach my $item (@array) {
		my $length = length($item);
		$hash{$length} += 1;
	}
}

# распечатать хеш
foreach my $key (keys %hash) {
	print "$key: $hash{$key}\n";
}