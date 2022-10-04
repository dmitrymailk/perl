open my $in, '<', 'words2.txt' or die $!;
open my $out, '>', 'words_ending_with_5_length.txt' or die $!;

while (my $line = <$in>) {
	chomp $line;
	my @words = split " ", $line;

	foreach my $word (@words) {
		if (length($word) <= 5) {
			print $out $word, "\n";
		}
	}
}
close $in;
close $out;