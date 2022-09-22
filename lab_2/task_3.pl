# Строка имеет вид "число+число:число+число". Вычислить соответствующее значение выражения.
my $expression = "2+2+4:2+0";
my @summands = split ':', $expression;
my @nums;
foreach my $summand (@summands) {
	my @summands = split '\+', $summand;
	my $sum = 0;
	foreach my $summand (@summands) {
		$sum += $summand;
	}
	push @nums, $sum;
}
print @nums[0] / @nums[1];