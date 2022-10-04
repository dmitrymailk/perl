1. Прочитать из файла слова и записать в другой файл только те из них, 
которые заканчиваются буквой 'в' в любом регистре.
```perl
open my $in, '<', 'words.txt' or die $!;
open my $out, '>', 'words_ending_with_v.txt' or die $!;
while (my $line = <$in>) {
	chomp $line;
	my @words = split " ", $line;
	
	foreach my $word (@words) {
		if ($word =~ /в$/i || $word =~ /В$/i) {
			print $out $word, "\n";
		}
	}
}
close $in;
close $out;
```

2. Вывести в файл таблицу умножения чисел от 1 до 9 в виде:

1	2	3	4	...9
2	4	6	8	...18
...
9	18			...81

```perl
open my $out, '>', 'multiplication_table.txt' or die $!;
for (my $i = 1; $i <= 9; $i++) {
	for (my $j = 1; $j <= 9; $j++) {
		print $out $i * $j, "\t";
	}
	print $out "\n";
}
close $out;
```


3. Записать из текстового файла отдельные абзацы в соответствующие элементы массива.
Вывести на экран каждый второй абзац, разделяя вывод пустой строкой.
```perl
open IN, "<", "text.txt" or die "Can't open file: $!";
my @text = <IN>; # read file into array
close IN;

for (my $i = 1; $i < @text; $i += 2) { 
    print $text[$i], "\n"; 
}
```

4. В файле записаны числа, отделенные друг от друга символом табуляции по строкам, отделенными символом '\n'. Запишите построчные суммы чисел в отдельный файл.
```perl
open my $in, '<', 'numbers.txt' or die $!;
open my $out, '>', 'sums.txt' or die $!;
while (my $line = <$in>) {
	chomp $line;
	my @numbers = split "\t", $line;
	my $sum = 0;
	
	foreach my $number (@numbers) {
		$sum += $number;
	}
	print $out $sum, "\n";
}
close $in;
close $out;
```

5. Найти в файле все слова, состоящие из не более 5 букв. Вывести их в файл и на экран.
```perl
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
```

6. (статистика по файлу) Дан файл. Определите сколько в нем букв, слов, строк. Выведите три найденных числа в формате, приведенном в примере. 

Input file contains:
108 letters 
20 words 
4 lines 

```perl
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
```

7. Переписать слова из файла в другой файл, нумеруя их.
```perl
open my $in, '<', 'words.txt' or die $!;
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
```