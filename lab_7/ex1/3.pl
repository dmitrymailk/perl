#!/usr/bin/perl
my $file = '3.txt'; # имя файла
open IN, '<', "$file" or die "Can't open file: $!"; # открываем файл на чтение
while (<IN>) { # читаем построчно
    chomp; # убираем символ перевода строки
    if ($_ =~ /[xyz].{5,17}[xyz]/) { # если строка содержит [xyz]{1}...[xyz]{1}
        print "$_\n"; # выводим строку
    }
}
close IN;