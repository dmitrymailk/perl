### Массивы

Текст, соответствующий входным требованиям условия, можно задать непосредственно в программе в виде литерала. Входные данные предварительно выводить на экран

1. Текст содержит список нумерованных предложений, начинающихся с новой строки. Сформировать массив этих предложений.
Вывести его на экран с разделителем элементов знаком процента.
$text = "1. Первое предложение
2. Второе предложение
3. Третье предложение
4. Четвертое предложение
";

```perl
my @sentences = split "

", $text;
print join "%", @sentences;
```

2. Записано арифметическое выражение вида
12+22+31+44+87+7.

Сформируйте массив слагаемых. Вычислите сумму и вывести ее на экран.
```perl
my $expression = "12+22+31+44+87+7";
my @summands = split '\+', $expression;
my $sum = 0;
foreach my $summand (@summands) {
	$sum += $summand;
}
print $sum;
```

3. Строка имеет вид "число+число:число+число". Вычислить соответствующее значение выражения.
```perl
my $expression = "12+22:31+44";
my @summands = split ':', $expression;
my $sum = 0;
foreach my $summand (@summands) {
	my @summands = split '\+', $summand;
	foreach my $summand (@summands) {
		$sum += $summand;
	}
}
print $sum;
```

4. Каждое слово предложения записать с новой строки.

5. Преобразовать слово, расставив между его буквами знаки "_". Вывести итоговое слово на экран.