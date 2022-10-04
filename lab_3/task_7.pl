open my $in, '<', 'text.txt' or die $!;
open my $out, '>', 'words_with_numbers.txt' or die $!;
my $i = 1;

while (my $line = <$in>) {
	chomp $line;
	my @words = split " ", $line;

	foreach my $word (@words) {
		print $out $i++, ". ", $word, "\n";
	}
}
close $in;
close $out;