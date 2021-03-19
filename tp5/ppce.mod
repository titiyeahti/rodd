
int T = 12;
range time = 1..T;

int M = 4;
range mode = 1..M;

int S = ...;
float d[time] = ...;

float E_max[time] = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4];

float h[time] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];


float p[mode][time] = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];

float f[mode][time] = [
  [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
  [30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30],
  [60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60],
  [90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90]];
  
float e[mode][time] = [
  [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8],
  [6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6],
  [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
  [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]];

/* Problem */

dvar boolean y[mode][time];
dvar float x[mode][time];
dvar float s[0..T];
dvar float cost;

minimize cost;

subject to {
  cost == sum (m in mode)(sum(t in time) (p[m][t]*x[m][t]+f[m][t]*y[m][t])) +
  sum (t in time) h[t]*s[t];
 

  forall (t in time) {
    sum(m in mode) (x[m][t] - s[t] + s[t-1]) == d[t];
    s[t] >= 0;
  }

  s[0] == 0;
  
  forall (m in mode){
    forall (t in time){
      x[m][t] <= y[m][t] * sum (t1 in t..T) d[t1];
      x[m][t] >= 0;
    }
  }

  /* slidddddiiiiiiiiiing constraint */
  /* saféréflércirent */
  forall (t in 1..(T-S)) {
    sum(t1 in t..(t+S)) sum(m in mode) (x[m][t1]*(e[m][t1] - E_max[t1])) <= 0;
  }
}


main {
  //ofstream logfile("Output.log");
  thisOplModel.generate();
  cplex.solve();
  thisOplModel.postProcess();
}


execute DISPLAY {
  write("##")
  write(S);
  write(" ");
  write(cost);
  write(" ");
  var ecm = 0;
  for (var m in mode)
    for (var t in time)
      ecm = ecm + x[m][t]*e[m][t];

  ecm = ecm / T;
  write(ecm);
  write("\n");
}
