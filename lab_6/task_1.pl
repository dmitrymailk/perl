use strict;
use warnings;
use v5.10; 
# подключить Dumper
use Data::Dumper;

package Train {
	# конструктор, Объявляем поля и привязываем к классу
	sub new {
		# new method - это конструктор класса
		my $class = shift;
		my $self = {
			_place => shift,
			_trainNum => shift,
			_arrival_time => shift,
		};
		bless $self, $class;
		# bless это встроенная функция, которая связывает объект с классом.
		return $self;
	}
	#getters
	sub place {
		my $self = shift;
		return $self->{_place};
	}
	sub trainNum {
		my $self = shift;
		return $self->{_trainNum};
	}
	sub arrival_time {
		my $self = shift;
		return $self->{_arrival_time}[0].":".$self->{_arrival_time}[1];
	}
	#setters
	sub set_place {
		my $self = shift;
		$self->{_place} = shift;
	}
	sub set_trainNum {
		my $self = shift;
		$self->{_trainNum} = shift;
	}
	sub set_arrival_time {
		my $self = shift;
		$self->{_arrival_time} = shift;
	}
	sub print {
		say "vvvvvvvvvvvvvvvvvvv";
		my $self = shift;
		say "Place: ", $self->place;
		say "Train number: ", $self->trainNum;
		say "arrival_time: ", $self->arrival_time;
		say "^^^^^^^^^^^^^^^^^^^";
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
	#fully equal time
	sub equal {
		my ($self, $other) = @_;
		return $self->{_arrival_time}[0] == $other->{_arrival_time}[0] && $self->{_arrival_time}[1] == $other->{_arrival_time}[1];
	}
	
	sub not_equal {
		return !equal(@_);
	}
	# first we compare time, then hours
	sub greater {
		my ($self, $other) = @_;
			if ($self->{_arrival_time}[0] > $other->{_arrival_time}[0]) {
				return 1;
			} elsif ($self->{_arrival_time}[0] < $other->{_arrival_time}[0]) {
				return 0;
			} else {
				if ($self->{_arrival_time}[1] > $other->{_arrival_time}[1]) {
					return 1;
				} else {
					return 0;
				}
			}	
	}
	# less is not greater && not equal
	sub less {
		return !greater(@_) && !equal(@_);
	}

	sub greater_or_equal {
		return greater(@_) || equal(@_);
	}
    
	sub less_or_equal {
		return less(@_) || equal(@_);
	}
	# compare method
	sub compare {
		my ($self, $other) = @_;
		if (equal($self, $other)) {
			say "Times are equal";
			return 0;
		} elsif (greater($self, $other)) {
			say "First time is greater";
			return 1;
		} else {
			say "Second time is greater";
			return -1;
		}
	}
	# overload stringification operator
	sub to_string {
		my $self = shift;
		return $self->{_arrival_time}[0] . ":" . $self->{_arrival_time}[1];
	}
}
# Класс описывающий массив поездов
package TrainStation {
	sub new {
		my $class = shift;
		my $self = {
			_trains => shift,
		};
		bless $self, $class;
		return $self;
	}
	sub trains {
		my $self = shift;
		return $self->{_trains};
	}
	sub set_trains {
		my $self = shift;
		$self->{_trains} = shift;
	}
	# Получаем переданное значение, затем проходимся по поездам и ищем похожие.
	sub print_train {
		say "--------Search by Number result--------";
		my $self = shift;
		my $trainNum = shift;
		my $flag = 0;
		foreach my $train (@{$self->trains}) {
			if ($train->trainNum =~ $trainNum) {
				$train->print;
				$flag = 1;
			}
		}
		if ($flag == 0) {
			say "No such record";
		}

		say "-----------------------";
	}
	# Получаем переданное значение, затем проходимся по поездам и ищем точно совпадающие.
	sub search {
		say "--------Search by Destination result--------";
		my $self = shift;
		my $destination = shift;
		my $flag = 0;
		foreach my $train (@{$self->trains}) {
			if ($train->place eq $destination) {
				$train->print;
				$flag = 1;
			}
		}
		if ($flag == 0) {
			say "No such record";
		}
	}
	# Сравниваем поезда по времени прибытия
	sub compare {
		say "----------------------- compare -----------------------";
		my $self = shift;
		my $pos_1 = shift;
		my $pos_2 = shift;
		my $record_1 = $self->trains->[$pos_1];
		my $record_2 = $self->trains->[$pos_2];
		$record_1->print;
		say "-----------------------";
		$record_2->print;
		say "-----------------------";
		$record_1 cmp $record_2;
	}
	sub print_all {
		say "-----------------------";
		my $self = shift;
		foreach my $train (@{$self->trains}) {
			$train->print;
		}
		say "-----------------------";
	}
}



# прочитать данный массив из файла, где записи разделены пробелом
my @trains = ();
open my $fh, "<", "names.txt" or die "Can't open file: $!";
while (<$fh>) {
	chomp;
	my @record = split " ";
	my @arrival_time = split /:/, $record[2];
	push @trains, Train->new($record[0], $record[1], \@arrival_time);
}

my $TrainStation = TrainStation->new(\@trains);
# \ перед @records - это ссылка на массив @records
$TrainStation->print_all();
$TrainStation->print_train("g");
$TrainStation->search("Krasnodar");
$TrainStation->compare(1, 5);
