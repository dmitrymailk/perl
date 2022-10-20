use open qw(:utf8);
binmode STDOUT,':utf8';

open my $in, "<", "task_2.txt" or die "Can't open file: $!";
my %hash = ();

while (my $line = <$in>) {
	my $string = $line;

	my @array = split /[\s,.]/, $string;
	foreach my $item (@array) {
		my $first_letter = substr($item, 0, 1);
		$first_letter = lc($first_letter);
		if($first_letter ne "") {
			$hash{$first_letter} .= "$item ";
		}
	}
}

# распечатать хеш
foreach my $key (keys %hash) {
	print "$key: $hash{$key}\n";
}