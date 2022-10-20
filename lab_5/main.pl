use open qw(:utf8);
binmode STDOUT,':utf8';
use Data::Dumper;
$Data::Dumper::Indent   = 1;

# read file 
$filename = "./название_задачи.txt";

use Storable qw(dclone);

sub CSVReader {
	my ($filename) = @_;
	my $delimeter = " ";
	my $str;
	my @str_arr;
	my %columns;
	my @columns_array;
	my $item;
	my $source_name;
	my $result;

	open my $in, "<", "$filename" or die "Can't open file: $!";

	# print first line
	$str = <$in>;

	# split by delimetr
	@str_arr = split $delimeter, $str;

	%columns = ();
	@columns_array = ();
	for $col_name (@str_arr) {
		$columns{$col_name} = ();
		push @columns_array, $col_name;
	}

	while($str = <$in>){
		@str_arr = split $delimeter, $str;

		for $i (0 .. scalar @str_arr-1) {
			$col_name = $columns_array[$i];
			$item = $str_arr[$i];
			push @{ $columns{$col_name} }, $item;

		}
	}

	# function get table value by x and y coordinates
	sub get_item {
		my($x, $y) = @_;
		my $source_name = $columns_array[$x];
		# get length of array
		my $len = len();
		if ($y < $len) {
			$item = $columns{$source_name}[$y];
			return $item;
		} else {
			die "Can't get line $y from $source_name, y > $len";
		}
	}

	sub set_item {
		my($x, $y, $value) = @_;
		my $source_name = $columns_array[$x];
		# get length of array
		my $len = scalar @{ $columns{$source_name} };
		if ($y < $len) {
			$columns{$source_name}[$y] = $value;
		} else {
			die "Can't set line $y from $source_name, y > $len";
		}
	}

	sub print_table {
		# my $header = join "\t", @columns_array;
		print "$header\n";
		for $j (0 .. len() - 1) {
			for $i (0 .. columns_amount() - 1) {
					my $item = get_item($i, $j);
					print "$item\t";
				}
				print("\n");
			}
		
		print "\n------------\n";
	}
	sub len {
		return scalar @{ $columns{$columns_array[0]} };
	}

	sub columns_amount {
		return scalar @columns_array;
	}

	sub save_table {
		my $filename = "./temp.txt";
		open my $out, ">", "$filename" or die "Can't open file: $!";
		my $header = join $delimeter, @columns_array;
		print $out "$header\n";

		for $j (0 .. len() - 1) {
			for $i (0 .. columns_amount() - 1) {
				my $item = get_item($i, $j);
				print $out "$item$delimeter";
			}
			print $out("\n");
		}
		close $out;
	}

	sub add_row {
		my $last_id = get_item(0, len() - 1);
		$last_id += 1;

		my @messages = (
			"Enter category please: ",
			"Enter model please: ",
			"Enter name_manufactorer please: ",
			"Enter address_manufactorer please: ",
			"Enter price please: ", 
			"Enter amount_in_shop please: ", 
			"Enter amount_in_stock please: ",
		);

		my $id_name = $columns_array[0];
		push @{ $columns{$id_name} }, $last_id;

		for $i (0 .. columns_amount() - 2) {
			print @messages[$i];
			my $item = <STDIN>;
			# my $item = @messages[$i];
			my $col_name = $columns_array[$i+1];
			
			chomp $item;
			push @{ $columns{$col_name} }, $item;
		}

	}

	sub delete_row {
		my $id = shift;
		my $id_name = $columns_array[0];
		my $index = -1;
		for $i (0 .. len() - 1) {
			if ($columns{$id_name}[$i] == $id) {
				$index = $i;
				last;
			}
		}

		if ($index == -1) {
			die "Can't find id $id";
		}
		
		for $i (0 .. columns_amount() - 1) {
			my $col_name = $columns_array[$i];
			splice @{ $columns{$col_name} }, $index, 1;
		}
	}

	sub sort_by {
		my $col_name = shift;
		my $sort_type = shift;

		my $index = -1;
		for $i (0 .. columns_amount() - 1) {
			if ($columns_array[$i] eq $col_name) {
				$index = $i;
				last;
			}
		}

		if ($index == -1) {
			die "Can't find column $col_name";
		}

		@sorted_array = ();
      	for($i = 0; $i < len()-1; $i++) {
			$item = get_item($index, $i);  
			push @sorted_array, [$i, $item];
		}

		# sort by first column
		if ($sort_type eq "asc") {
			@sorted_array = sort { $a->[1] <=> $b->[1] } @sorted_array;
		} else {
			@sorted_array = sort { $b->[1] <=> $a->[1] } @sorted_array;
		}

	 	@sorted_indexes = ();

		for($i = 0; $i < len()-1; $i++) {
			$index = $sorted_array[$i][0];
			push @sorted_indexes, $index;
		}

		%new_columns = ();
		for $col_name (@columns_array) {
			$new_columns{$col_name} = ();
		}

		for $sorted_id (@sorted_indexes) {
			for($i=0; $i<columns_amount(); $i++) {
				my $col_name = $columns_array[$i];
				my $item = get_item($i, $sorted_id);
				push @{ $new_columns{$col_name} }, $item;
			}
		}
		%columns = %new_columns;
	}
}	

my $csv_table = CSVReader($filename);
# $csv_table.set_item(0, 1, "test");
# $csv_table.add_row();
# $csv_table.save_table();
# $csv_table.delete_row(12);
$csv_table.sort_by("amount_in_stock", "asc");
# $csv_table.sort_by("price", "asc");
$csv_table.print_table();
$csv_table.save_table();