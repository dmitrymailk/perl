# 1. Прочитать из файла слова и записать в другой файл только те из них, 
# которые заканчиваются буквой 'в' в любом регистре.

open my $in, '<', 'words.txt' or die $!;
open my $out, '>', 'words_ending_with_v.txt' or die $!;
while (my $line = <$in>) {
	chomp $line;
	my @words = split " ", $line;
	
	foreach my $word (@words) {
		# Do case-insensitive pattern matching. For example, "A" will match "a" under /i.
		if ($word =~ /[вВ]$/) {
			print $out $word, "\n";
		}
	}
}
close $in;
close $out;