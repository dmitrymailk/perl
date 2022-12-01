#!/usr/bin/perl
my $file = '1.txt';
open IN, '<', "$file" or die "Can't open file: $!";
while (<IN>) { # считывание построчно
    chomp;
    if ($_ =~ /cat.*cat/) { # поиск подстроки cat в строке
        print "$_\n"; # вывод строки
    }
}
close IN;