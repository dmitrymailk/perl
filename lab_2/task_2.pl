# 2. Записано арифметическое выражение вида
# 12+22+31+44+87+7.

# Сформируйте массив слагаемых. Вычислите сумму и вывести ее на экран.


# solution 1
# my $text = "12+22+31+44+87+7";
my $text = "1+2+3";
print($text);

my @chars_array = split ("\\+", $text);
my $sum = 0;
foreach $num (@chars_array)
{
    $sum += $num;
}
print("=$sum\n");

# solution 2
my $expression = "12+22+31+44+87+7";
my @summands = split '\+', $expression;
my $sum = 0;
foreach my $summand (@summands) {
	$sum += $summand;
}
print $sum;

