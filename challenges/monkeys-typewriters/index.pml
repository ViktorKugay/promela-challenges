#define MONKEYS 26
#define LENGTH 13

byte str[LENGTH] = {
  't', 'o', 'b', 'e', 'o', 'r', 'n', 'o', 't', 't', 'o', 'b', 'e'
};
// канал для передачи символов от обезъянки к ревьюеру
chan char = [0] of {byte};
// массив каналов для остановки каждой отдельной обезъянки
chan stop[MONKEYS] = [MONKEYS] of {byte};
// глобальный счетчик остановленных обезъянок
byte stop_counter = 0;

proctype monkey(chan controller; byte c) {
  byte needStop;
  do
    // // needStop != 1, потому что пока не поступил сигнал о том, 
    // что обезъянке нужно остановиться обезъянка посылает свой символов ревьюеру
    :: needStop != 1 -> {
      char!c;
    }
    :: controller?needStop -> {
      // stop_counter++, потому что обезъянка инкрементирует счетчик остановленных обезъянок
      // чтобы ревьюер мог убедиться, что все процессы обезъянок остановлены
      // и тоже остановиться
      stop_counter++;
      break;
    }
  od
}

proctype reviewer() {
  int monkeys = MONKEYS;
  int length = LENGTH;

  byte arr[LENGTH];
  
  int acc, i;

  do
    :: stop_counter == monkeys -> {
      printf("success");
      break;
    }
    :: char?arr[length - 1] -> {
      // сдвигаем массив накопленных символов влево на один элемент
      // и добавляем новый символ в конец строки
      for (i: 0..length - 2) {
        acc = arr[i+1];
        arr[i] = acc;
      }

      if
        :: arr[0] == str[0] &
        arr[1] == str[1] &
        arr[2] == str[2] &
        arr[3] == str[3] &
        arr[4] == str[4] &
        arr[5] == str[5] &
        arr[6] == str[6] &
        arr[7] == str[7] &
        arr[8] == str[8] &
        arr[9] == str[9] &
        arr[10] == str[10] &
        arr[11] == str[11] &
        arr[12] == str[12] -> {
          // уведомляем всех обезьян о том, что нужно прекратить 
          // нажимать на кнопки и завершить процесс
          for (i: 0..monkeys - 1) {
            stop[i]!1;
          }
        }
        :: else -> {
          skip;
        }
      fi
    }
  od
}

init {
  byte i, j;

  run reviewer()

  for (i: 'a'..'z') {
    run monkey(stop[j], i);
    j++;
  }
}