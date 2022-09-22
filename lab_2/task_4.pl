# 4. Каждое слово предложения записать с новой строки.

my $sentence = "This is sample sentence for task 4";

my @words = split " ", $sentence;

foreach my $word (@words) {
	print "$word\n";

}
