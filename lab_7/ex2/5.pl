#!/usr/bin/perl
my $file = '5.txt'; # имя файла
open IN, '<', "$file" or die "Can't open file: $!"; # открываем файл на чтение
while (<IN>) { # читаем построчно
    chomp; # убираем символ перевода строки
    if ($_ =~ s/(\w)\1+/$1/g) { 
    # s - замена
    # \w - буква
    # \1 - первая буква
    # + - один или болееattraction
    # $1 - первая буква
    # g - заменить все вхождения
        print "$_\n"; # выводим строку
    }
}
close IN;