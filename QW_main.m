close all;
clear all;
clc

Number_Of_Dimensions=100;
Number_Of_Steps=100;
%Number_Of_Steps=input('Enter the total number of steps: ');
%epsilon=input('Epsilon value is: ');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('~~~~~ RUNNING ~~~~\n')
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')

position=zeros(2,100,2*Number_Of_Dimensions+1);
deviation1=zeros(100,Number_Of_Dimensions);
deviation2=zeros(100,Number_Of_Dimensions);

i = sqrt(-1);
theta = pi/4;

% Unitary Coin Reshuffling matrices
Identity_Coin = eye(2);

Not_Coin 	  = [0 1;
				 1 0];

Hadamard_Coin = 1/sqrt(2).*hadamard(2);

Y_Coin 		  = 1/sqrt(2).*[1  i;
				 			i  1];

Rotation_Coin = [cos(theta) -sin(theta);
				 sin(theta)  cos(theta)];

% Basis kets
ket_zero  = [1;0];
ket_one   = [0;1];

% Basis bras
bra_zero  = [1 0];
bra_one   = [0 1];

% Basis projections
Proj_zero = [1 0;
			 0 0];

Proj_one  = [0 0;
			 0 1];

% Ιnitial coin = (|0> + i|1>)/sqrt(2) or (i|0> + |1>)/sqrt(2)
coin_balanced = [cos(theta);i*sin(theta)];

% X axis:
X_axis = -Number_Of_Dimensions:1:Number_Of_Dimensions;

% Walker's matrices:
ket = eye(2*Number_Of_Dimensions+1);
v1  = ones(1,2*Number_Of_Dimensions);
increment = diag(v1,-1);
decrement = diag(v1,1);

% BRA
% ket(1,:);

% KET
% ket(:,1);

% Coin Density Matrix (ρ_c)
coin_density = coin_balanced*coin_balanced';
%coin_density = Y_Coin;
%coin_density = Hadamard_Coin;
%coin_density = Proj_zero;

% Place walker in middle
walker_density = ket(:,Number_Of_Dimensions+1)*ket(Number_Of_Dimensions+1,:);

% Walker Density Matrix (ρ_w)
coin_walker_density  = kron(coin_density, walker_density);

% Evolution operators
V_cl = kron(Proj_zero, increment) + kron(Proj_one, decrement);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Commence Walking %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
index=1;
for e = 0.01:0.01:1
	fprintf('Step = %d/100\n',index)

	Phase_Coin1 = 1/sqrt(1+e^2).*[1 e;-e 1];
	Phase_Coin2 = 1/sqrt(1+e^2).*[1 -e;e 1];

	V_q1 = V_cl*kron(Phase_Coin1, ket);
	V_q2 = V_cl*kron(Phase_Coin2, ket);

	[position(1,index,:),deviation1(index,:)] = QW_ambainis(Number_Of_Steps, Number_Of_Dimensions, V_q1, coin_walker_density);
	[position(2,index,:),deviation2(index,:)] = QW_avrg(Number_Of_Steps, Number_Of_Dimensions, V_q1, V_q2, coin_walker_density);

	index = index+1;
end
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('~~~~ COMPLETE ~~~~\n')
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')