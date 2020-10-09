//TO SOLVE SPHERICAL WAVE SCHRODINGER EQUATION USING VECTOR SPACES AND FINITE DIFFERENCE METHOD
//BY VISHU SAINI
//7 OCT. 2020


//GIVEN WAVE EQUATION IS OF THE FORM
/* 
        y''= A(r)y(r)
        y(0)=0
        y(n)=0  lim n-->inf
*/


/* We write the above equation in form:
        H|y> = E|y>         ..(Eigen Value Problem)

where,
H=T+V (Hamiltonian Operator)

Also, ket |y> is a vector of N dimensional function space(N is user input)

*/        




clc()
clear

//1.Initialize the problem
/*a.Define Constants */
c=1
Am=1e-10
hbar = 1973
e=3.795
m=0.511e6/c^2

k=m/(hbar)^2


/*b.Initialize Potential Function*/
function p=potential(r)
     p = -(e^2)/r
endfunction

/*c.Boundary Conditions*/
a=0.00001
b=10
ya=0
yb=0

//Discrete N dimensional Vector Space
N=input("Enter dimension of Function Space N ")

h=(b-a)/(N-1)  //step-size

/*a.Iniitalize R array(grid points)*/
for i=1:N
     R(i,1)=0
end

R(1,1)= a

for i=2:N
     R(i,1)=a+(i-1)*h
end



/*b.Initialize |y> */
for i=1:N
    Y(i,1)=0
end

Y(1,1)=ya
Y(N,1)=yb

/*We will plot three eigenfunctions in end*/
Y1=Y
Y2=Y
Y3=Y

//2.HAMILTONIAN MATRIX

/* a.Kinetic energy matrix */
for i=1:N-2
    for j=1:N-2
        A(i,j)=0
end
end

for i=1:N-2
    A(i,i)=-2
end

for i=1:N-3
    A(i+1,i)=1
    A(i,i+1)=1   
end

K=-A/(2*h*h*k)     //KE matirx


/*b. Potential Matrix */
for i=1:N-2
    V(i,i)=potential(R(i+1,1))  
end


/*c. Hamiltonian matrix*/
H=K+V


//3.Eigen Value Problem
[c,d]=spec(H)


disp("Eigenfunctions To Be Plotted")
disp("Enter for which Eigenvalue, eigenfunctions are to be plotted (integer)  ")
u=input("Enter first value ")
v=input("Enter second value ")
w=input("Enter third value ")

disp("Corresponding Eigen Values")
disp(d(u,u))
disp(d(v,v))
disp(d(w,w))



/*b.eigenfunction*/
for i=1:N-2
    Y1(i+1,1)=c(i,u)                //eigenfunction for 1st eigenvalue
end

for i=1:N-2
    Y2(i+1,1)=c(i,v)               //eigenfunction for 2nd eigenvalue
end

for i=1:N-2
    Y3(i+1,1)=c(i,w)               //eigenfunction for 5th eigenvalue
end

//4.PLOT THE EIGENFUNTIONS AND PROBABLITY DENSITIES

clf()
/*a.Eigenfunctions*/
subplot(121)
plot2d(R,Y1,1)
plot2d(R,Y2,2)
plot2d(R,Y3,5)

xtitle("Eigenfunctions", boxed=%t)
g = gca()// axes handle
g.x_location = "origin"
g.y_location = "origin"
g.box = "on"
xgrid(7,1,1)

legend("Eigenfunction "+string(u)+"","Eigenfunction "+string(v)+"","Eigenfunction "+string(w)+"")

/*b.Probability densitites*/
subplot(122)
plot2d(R,Y1^2,1)
plot2d(R,Y2^2,2)
plot2d(R,Y3^2,5)

xtitle("Probabiltiy densities for Eigenfunctions", boxed=%t)

g = gca()// axes handle
g.x_location = "origin"
g.y_location = "origin"
g.box = "on"
xgrid(6,1,1)
legend("Probability Density "+string(u)+"","Probability Density "+string(v)+"","Probability Density "+string(w)+"")


