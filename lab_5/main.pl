use open qw(:utf8);
binmode STDOUT,':utf8';
use Data::Dumper;
$Data::Dumper::Indent   = 1;

# read file 
$filename = "./название_задачи.txt";


sub CSVReader {
	my ($filename) = @_;
	my $delimeter = " ";
	my $str;
	my @str_arr;
	my %columns;
	my @columns_array;
	my $col_name;
	my $i;
	my $item;
	my $source_name;
	my $len;
	my $result;
	my $columns_amount;

	open my $in, "<", "$filename" or die "Can't open file: $!";

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

	$columns_amount = scalar @columns_array;

	# fill hash with data using names as keys
	while($str = <$in>){
		@str_arr = split $delimeter, $str;

		for $i (0 .. scalar @str_arr-1) {
			$col_name = $columns_array[$i];
			$item = $str_arr[$i];
			push @{ $columns{$col_name} }, $item;

		}
	}

	$len = scalar @{ $columns{$columns_array[0]} };

	# function get table value by x and y coordinates
	sub get_table {
		my($x, $y) = @_;
		my $source_name = $columns_array[$x];
		# get length of array
		my $len = scalar @{ $columns{$source_name} };
		if ($y < $len) {
			$item = $columns{$source_name}[$y];
			return $item;
		} else {
			die "Can't get line $y from $source_name, y > $len";
		}
	}

	sub print_table {
			for $j (0 .. $len - 1) {
		for $i (0 .. $columns_amount - 1) {
				my $item = get_table($i, $j);
				print "$item\t";
			}
			print("\n");
		}
	}

}

my $csv_reader = CSVReader($filename);
$csv_reader.print_table();