open my $in, '<', 'text.txt' or die $!;
my $letters = 0;
my $words = 0;
my $lines = 0;

while (my $line = <$in>) {
	chomp $line;
	$letters += length($line);
	$words += scalar(split " ", $line);
	$lines++;
}

print "Input file contains:\n";
print "$letters letters\n";
print "$words words\n";
print "$lines lines\n";
close $in;