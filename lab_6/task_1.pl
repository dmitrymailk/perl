use strict;
use warnings;
use v5.10; 
# подключить Dumper
use Data::Dumper;

package Record {
	sub new {
		# new method - это конструктор класса
		my $class = shift;
		my $self = {
			_surname => shift,
			_name => shift,
			_phone => shift,
			_date => shift,
		};
		bless $self, $class;
		# bless это встроенная функция, которая связывает объект с классом.
		return $self;
	}
	sub surname {
		my $self = shift;
		return $self->{_surname};
	}
	sub name {
		my $self = shift;
		return $self->{_name};
	}
	sub phone {
		my $self = shift;
		return $self->{_phone};
	}
	sub date {
		my $self = shift;
		return $self->{_date};
	}
	sub set_surname {
		my $self = shift;
		$self->{_surname} = shift;
	}
	sub set_name {
		my $self = shift;
		$self->{_name} = shift;
	}
	sub set_phone {
		my $self = shift;
		$self->{_phone} = shift;
	}
	sub set_date {
		my $self = shift;
		$self->{_date} = shift;
	}
	sub print {
		my $self = shift;
		say "Surname: ", $self->surname;
		say "Name: ", $self->name;
		say "Phone: ", $self->phone;
		say "Date: ", $self->{_date}[0], ".", $self->{_date}[1], ".", $self->{_date}[2];	
	}
	# overload comparison operators for date
	use overload
		'==' => \&equal,
		'!=' => \&not_equal,
		'>' => \&greater,
		'<' => \&less,
		'>=' => \&greater_or_equal,
		'<=' => \&less_or_equal,
		'cmp' => \&compare,
		'""' => \&to_string;
	sub equal {
		my ($self, $other) = @_;
		return $self->{_date}[0] == $other->{_date}[0] && $self->{_date}[1] == $other->{_date}[1] && $self->{_date}[2] == $other->{_date}[2];
	}
	sub not_equal {
		my ($self, $other) = @_;
		return $self->{_date}[0] != $other->{_date}[0] || $self->{_date}[1] != $other->{_date}[1] || $self->{_date}[2] != $other->{_date}[2];
	}

	sub greater {
		my ($self, $other) = @_;
		if ($self->{_date}[2] > $other->{_date}[2]) {
			return 1;
		} elsif ($self->{_date}[2] < $other->{_date}[2]) {
			return 0;
		} else {
			if ($self->{_date}[1] > $other->{_date}[1]) {
				return 1;
			} elsif ($self->{_date}[1] < $other->{_date}[1]) {
				return 0;
			} else {
				if ($self->{_date}[0] > $other->{_date}[0]) {
					return 1;
				} else {
					return 0;
				}
			}
		}
	}

	sub less {
		return !greater(@_) && !equal(@_);
	}

	sub greater_or_equal {
		return greater(@_) || equal(@_);
	}

	sub less_or_equal {
		return less(@_) || equal(@_);
	}

	sub compare {
		my ($self, $other) = @_;
		if (equal($self, $other)) {
			say "Dates are equal";
			return 0;
		} elsif (greater($self, $other)) {
			say "First date is greater";
			return 1;
		} else {
			say "Second date is greater";
			return -1;
		}
	}

	sub to_string {
		my $self = shift;
		return $self->{_date}[0] . "." . $self->{_date}[1] . "." . $self->{_date}[2];
	}
}

package Notebook {
	sub new {
		my $class = shift;
		my $self = {
			_records => shift,
		};
		bless $self, $class;
		return $self;
	}
	sub records {
		my $self = shift;
		return $self->{_records};
	}
	sub set_records {
		my $self = shift;
		$self->{_records} = shift;
	}
	sub print_human {
		my $self = shift;
		my $phone = shift;
		my $flag = 0;
		foreach my $record (@{$self->records}) {
			if ($record->phone eq $phone) {
				$record->print;
				$flag = 1;
			}
		}
		if ($flag == 0) {
			say "No such record";
		}

		say "-----------------------";
	}
	sub search {
		my $self = shift;
		my $digits = shift;
		my $flag = 0;
		foreach my $record (@{$self->records}) {
			if (substr($record->phone, 0, 3) eq $digits) {
				$record->print;
				$flag = 1;
			}
		}
		if ($flag == 0) {
			say "No such record";
		}
	}

	sub compare {
		say "----------------------- compare -----------------------"; 
		my $self = shift;
		my $pos_1 = shift;
		my $pos_2 = shift;
		my $record_1 = $self->records->[$pos_1];
		my $record_2 = $self->records->[$pos_2];
		$record_1->print;
		say "-----------------------";
		$record_2->print;
		say "-----------------------";
		$record_1 cmp $record_2;
	}

}



# прочитать данный массив из файла, где записи разделены \t
my @records = ();
open my $fh, "<", "names.txt" or die "Can't open file: $!";
while (<$fh>) {
	chomp;
	my @record = split " ";
	my @date = split /\./, $record[3];
	push @records, Record->new($record[0], $record[1], $record[2], \@date);
}
for (my $i = 0; $i < 10; $i++) {
	$records[$i]->print;
}

my $notebook = Notebook->new(\@records);
# \ перед @records - это ссылка на массив @records
$notebook->print_human("123456785");
$notebook->search("324");
$notebook->compare(6, 1);
$notebook->compare(0, 1);