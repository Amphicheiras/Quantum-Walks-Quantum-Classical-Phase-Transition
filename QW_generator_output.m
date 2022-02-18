%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Init for ε E (0,1) (mixed diffusion)         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
%subplot(2,2,1)
e = [0.01,0.5,1];
e_index=e*e_total;
hold on
for x=1:e_total
	plot(X_axis,p_nk(e_index,:))
end
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ARISTERA EINAI TO EPISLON
% DEKSIA EINAI TO N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(1,2,1)
hold on
plot(X_axis_positive,deviation(e_index,:))
xlabel('walker step') 
ylabel('SD') 
%legend(num2str(e_index(1)/N_max),num2str(e_index(2)/N_max),num2str(e_index(3)/N_max),'Location','northwest')
%plot(X_axis_positive,sqrt(tangent),'--')
hold off
%
subplot(1,2,2)
hold on   
%y = fft(p_nk2);   
%fs = 1/X_axis2(1);
%f = (0:length(y)-1)*fs/length(y);
%plot(f,abs(y))
n_index=[1,5,100];
plot(X_axis_epsilon,deviation(:,n_index))
xlabel('epsilon value') 
ylabel('SD') 
%legend(num2str(n_index(1)),num2str(n_index(2)),num2str(n_index(3)))
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     3d plotting                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
hold on
x=1:N_max;
y=1./sqrt(x);
size(x);
size(y);
for k=1:N_max
	l=round(1/sqrt(k),3);
	e_total*l;
	k;
	resonance_curve(k) = deviation(int8(e_total*l),k);
end
size(resonance_curve);
plot3(x(1,1:100),y(1,1:100),resonance_curve(1,1:100),'LineWidth',2.0,'Color','k')
size(X_axis_epsilon);
size(X_axis_positive);
size(deviation);
surfl(X_axis_positive(1,1:100),X_axis_epsilon,deviation(1:1000,1:100))
colormap(pink)
shading interp
grid on;
xlabel('Number of steps');
zlabel('Standard deviation');
ylabel('Epsilon');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Init for ε E (0,1) (mixed diffusion)         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%[X_axis,p_nk,X_axis_positive,tangent,deviation] = walk(N_max, epsilon_2);
%
%subplot(1,2,1)
%hold on
%plot(X_axis2,p_nk2)
%hold off
%
%subplot(1,2,2)
%hold on
%plot(X_axis_positive2,sqrt(deviation2),'-','LineWidth',2)
%plot(X_axis_positive,sqrt(tangent),'--')
%hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Init for ε = 0 (fully quantum diffusion)       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%[X_axis,p_nk,X_axis_positive,tangent,deviation] = walk(N_max, 0);
%subplot(1,2,1)
%hold on
%plot(X_axis,p_nk)
%hold off
%
%subplot(1,2,2)
%hold on
%plot(X_axis_positive,sqrt(deviation),'--','LineWidth',2)
%hold off
                   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Init for ε = 1 (fully classical diffusion)     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%[X_axis,p_nk,X_axis_positive,tangent,deviation] = walk(N_max, 1);
%
%subplot(1,2,1)
%hold on
%plot(X_axis,p_nk)
%title(['epsilon = ',num2str(e_total)])
%hold off

%title(['1st epsilon = ',num2str(e_total), ' & 2nd epsilon = ',num2str(epsilon_2)])
%legend('1st mixed walk','2nd mixed walk','Quantum walk','Classical walk')
%legend('0.3 -> 0.5 -> 0.1','0.1 -> 0.5 -> 0.3')

%subplot(1,2,2)
%hold on
%plot(X_axis_positive,sqrt(deviation),'--','LineWidth',2)
%hold off

%legend('0.3 -> 0.5 -> 0.1','0.1 -> 0.5 -> 0.3')
%title(['1st epsilon = ',num2str(e_total), ' has N = ',num2str(1/e_total^2), ...
%    ' & 2nd epsilon = ',num2str(epsilon_2), ' has N = ',num2str(1/epsilon_2^2)])
%legend('1st epsilon','1st tangent','2nd epsilon','2nd tangent', ...
%    'Quantum diffusion','Classical diffusion','Location','northwest')