#!/usr/bin/perl
my $file = '2.txt'; # имя файла
open IN, '<', "$file" or die "Can't open file: $!"; # открываем файл на чтение
while (<IN>) { # читаем построчно
    chomp; # убираем символ перевода строки
    if ($_ =~ /z...z/) { # если строка содержит z...z
        print "$_\n"; # выводим строку
    }
}
close IN;