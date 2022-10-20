# открыть файл с операндом чтения файла 
# случае ошибки вывести на экран
# $! это специальная переменная, которая содержит сообщение об ошибке
open my $in, "<", "task_1.txt" or die "Can't open file: $!";

while (my $line = <$in>) {
	# <$in> это более краткий способ прочитать строку из файла чем readline($in)
	# каждый вызов читает и возвращает следующую строку, пока не будет достигнут конец файла
	my $string = $line;

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
