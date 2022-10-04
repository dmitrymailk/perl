open IN, "<", "text.txt" or die "Can't open file: $!";
my @text = <IN>; # read file into array
close IN;

for (my $i = 1; $i < @text; $i += 2) { 
    print $text[$i], "\n"; 
}