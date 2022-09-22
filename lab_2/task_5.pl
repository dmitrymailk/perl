# Преобразовать слово, расставив между его буквами знаки "_". Вывести итоговое слово на экран.

use strict;
use warnings;

my $word = "stopword";

my @letters = split "", $word;
my $result = join "_", @letters;
print "$result\n";