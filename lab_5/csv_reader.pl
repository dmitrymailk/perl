use open qw(:utf8);
binmode STDOUT,':utf8';
use Data::Dumper;
$Data::Dumper::Indent   = 1;

# read file 
$filename = "./название_задачи.txt";
# open(TXT, "") or die "Couldn't open file for reading";
open my $in, "<", "$filename" or die "Can't open file: $!";

$delimeter = " ";
# print first line
$str = <$in>;

# split by delimetr
@str_arr = split $delimeter, $str;

# create hash with column names as keys and values as empty lists and create map with indexes
%columns = ();
@columns_array = ();
for $col_name (@str_arr) {
	$columns{$col_name} = ();
	push @columns_array, $col_name;
}

# fill hash with data using names as keys
while($str = <$in>){
	@str_arr = split $delimeter, $str;

	for $i (0 .. scalar @str_arr-1) {
		$col_name = $columns_array[$i];
		$item = $str_arr[$i];
		print "$col_name - $item\n";
		push @{ $columns{$col_name} }, $item;
	}
	print("------");
}

# # # print Dumper \%columns["ID"];

# # # function get table value by x and y coordinates
sub get_table {
	my($x, $y) = @_;
	my $source_name = $columns_array[$x];
	# get length of array
	$len = scalar @{ $columns{$source_name} };
	print("len = $len\n");
	if ($y < $len) {
		$item = $columns{$source_name}[$y];
		return $item;
	} else {
		die "Can't get line $y from $source_name, y > $len";
	}
}

$result  = get_table(1, 11);
print "$result\n";
