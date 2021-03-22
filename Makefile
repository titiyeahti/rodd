SRC=src/
TARGET = gen_inst_tp2.out gen_inst_tp3.out gen_inst_tp4.out

all : $(TARGET)

gen_inst_tp%.out : gen_matrix.o $(SRC)gen_inst_tp%.c
	cc $^ -o $@

%.o : $(SRC)%.c $(SRC)%.h
	cc -c $< -o $@

clear :
	rm -rf *.o *.out intances/*.dat



