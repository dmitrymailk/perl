use strict;
use warnings;
use v5.10; 

package Record {
	sub new {
		my $class = shift;
		my $self = {
			_surname => shift,
			_name => shift,
			_phone => shift,
			_date => shift,
		};
		bless $self, $class;
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
		say "Date: ", $self->date;
	}
	sub compare {
		my $self = shift;
		my $other = shift;
		return $self->date <=> $other->date;
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
	sub print {
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
		my $self = shift;
		my $other = shift;
		my $flag = 0;
		foreach my $record (@{$self->records}) {
			foreach my $other_record (@{$other->records}) {
				if ($record->compare($other_record) == 0) {
					$record->print;
					$flag = 1;
				}
			}
		}
		if ($flag == 0) {
			say "No such record";
		}
	}
}

my @records = (
	Record->new("Ivanov", "Ivan", "123456789", 1990),
	Record->new("Petrov", "Petr", "123456788", 1991),
	Record->new("Sidorov", "Sidor", "123456787", 1992),
	Record->new("Ivanov", "Ivan", "123456786", 1993),
	Record->new("Petrov", "Petr", "123456785", 1994),
	Record->new("Sidorov", "Sidor", "123456784", 1995),
	Record->new("Ivanov", "Ivan", "123456783", 1996),
	Record->new("Petrov", "Petr", "123456782", 1997),
	Record->new("Sidorov", "Sidor", "123456781", 1998),
	Record->new("Ivanov", "Ivan", "123456780", 1999),
);

my $notebook = Notebook->new(\@records);
$notebook->print("123456789");
$notebook->search("123");
$notebook->compare(Notebook->new(\@records));