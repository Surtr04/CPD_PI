!polu = [1, 2, 3, 4, 4];
polu = [3, 2, 3, 4];

!cell_centroids_x = [3, 3, 1, 5, 3];
!cell_centroids_y = [3, 5, 3, 3, 1];
cell_centroids_x = [0.65315407590812946, 0.33044570837100162, 1.4877749356984871, 0.42621098567548826];
cell_centroids_y = [1.5558437723294212,  1.0756553932058688,  1.7002254611119723, 2.1704981427461889];

x0 = cell_centroids_x(1);
y0 = cell_centroids_y(1);


x_values  = cell_centroids_x - x0;
y_values  = cell_centroids_y - y0;
x_squares = x_values.^2;
y_squares = y_values.^2;

A = [sum(x_squares),            sum(x_values .* y_values), sum(x_values);
     sum(x_values .* y_values), sum(y_squares),            sum(y_values);
     sum(x_values),             sum(y_values),             length(polu)];
 
R = [sum(polu .* x_values);
     sum(polu .* y_values);
     sum(polu)];
 
X = linsolve(A, R), ABC = inv(A) * R, avg = sum(polu)/length(polu)