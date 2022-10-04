ХЭШИ

Замечание. Количество строк в файле неизвестно, но более одной.

1. преобразовать строку "name:Имя Отчество Фамилия, email:name@mail.su, age:27" в хеш.
```perl
open my $in, "<", "task_1.txt" or die "Can't open file: $!";

while (my $line = <$in>) {
	my $string = $line;
	# replace \n from string
	$string =~ s///g;

	my %hash = ();
	my @array = split ", ", $string;
	foreach my $item (@array) {
		my ($key, $value) = split ":", $item;
		$hash{$key} = $value;
	}

	# распечатать хеш
	foreach my $key (keys %hash) {
		print "$key: $hash{$key}\n";
	}
	print("\n----\n");
}

```


2. Необходимо из слов файла организовать хеш. Ключами хеша являются буквы русского алфавита, а значениями строки, содержащие разделенные пробелами слова, начинающиеся на букву (обоих регистров), указанную в ключе хеша.
```perl
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
		my $first_letter = substr($item, 0, 1);
		$hash{$first_letter} .= "$item ";
	}
}

# распечатать хеш
foreach my $key (keys %hash) {
	print "$key: $hash{$key}\n";
}
```


3. Для  заданного текстового файла построить ассоциативный массив, ключами которого будут числа, а значениями количество  слов из файла, количество букв в которых равно ключу хеша.
```perl
use open qw(:utf8);
binmode STDOUT,':utf8';

open my $in, "<", "task_3.txt" or die "Can't open file: $!";
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
```
