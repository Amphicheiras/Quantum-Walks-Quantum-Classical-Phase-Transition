clear all;
%close all;
i=sqrt(-1);

N_max = input('Enter the number of iterations (e.g. 100): ');
%N_max=0;
e = input('Enter the value of epsilon #1 between 0 and 1:');
e_total=1;
%epsilon_2=input('Enter a number of epsilons:');

X_axis=-N_max:1:N_max;
deviation=zeros(e_total,N_max);
X_axis_positive=[];
X_axis_epsilon=[];
p_nk=zeros(e_total,2*N_max+1);
for r=1:N_max
    X_axis_positive=[X_axis_positive,r];
end
for r_e=1:e_total
    X_axis_epsilon=[X_axis_epsilon,r_e/e_total];
end

% Commence walking
tic
epsilon=1;
if N_max>0
    a_nk=[zeros(1,N_max),cos(pi/4)^2,zeros(1,N_max)]; 
    b_nk=[zeros(1,N_max),sin(pi/4)^2,zeros(1,N_max)]; 
    for N_current=1:N_max
        if N_current<50
            e = 0.01
        elseif N_current>=50 && N_current<100
            e = 0.9
        elseif N_current>=100
            e=0.1
        end
        a_nk_temp=a_nk;    % a_nk_temp is α_N, a_nk is α_N+1
        b_nk_temp=b_nk;    % b_nk_temp is β_N, b_nk is β_N+1
        a_nk=[0,a_nk_temp(1,1:2*N_max)+((e/e_total)^2)*b_nk_temp(1,1:2*N_max)]/(1+(e/e_total)^2);
        b_nk=[b_nk_temp(1,2:2*N_max+1)+((e/e_total)^2)*a_nk_temp(1,2:2*N_max+1),0]/(1+(e/e_total)^2);
        p_nk(epsilon,:)=abs(a_nk)+abs(b_nk);

        % Deviation Calculation
        deviation_temp=0;
        for k=1:(2*N_max+1)
            deviation_temp=deviation_temp+p_nk(epsilon,k)*(-N_max+k-1)^2;
        end
        deviation_temp=sqrt(deviation_temp);
        if N_current==1
            deviation(epsilon,:)=[deviation_temp,deviation(epsilon,2:N_max)];
        elseif N_current==N_max
            deviation(epsilon,:)=[deviation(epsilon,1:N_max-1),deviation_temp];
        else
            deviation(epsilon,:)=[deviation(epsilon,1:N_current-1),deviation_temp,deviation(epsilon,N_current+1:N_max)];
        end
    end
elseif N_max==0
    p_nk=abs(cos(pi/4)^2)+abs(i*sin(pi/4)^2);
end
toc
