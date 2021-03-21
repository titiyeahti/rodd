TARGET = gen_inst_tp2.out gen_inst_tp3.out gen_inst_tp4.out

all : $(TARGET)

gen_inst_tp%.out : gen_inst_tp%.c gen_matrix.o
	cc $^ -o $@

test.out : crash_test.c gen_matrix.o
	cc $^ -o $@

%.o : $(SRC)%.c $(SRC)%.h
	cc -c $< -o $@

clear :
	rm -rf *.o *out intances/*.dat



