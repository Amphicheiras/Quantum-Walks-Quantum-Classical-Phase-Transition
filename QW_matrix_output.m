steps  =input('Draw for step #[1-100] = ');
epsilon=input('Draw for epsilon[0.001-1] = ')*100;

clear deviation3
clear deviation4

x=1:100;
e=0.01:0.01:1;
size(e)
y=1./sqrt(x);

for k=x
	l=round(1/sqrt(k),2);
	%fprintf("k -> %d, int(l) ->  %d\n",k,int8(100*l));
	%fprintf("!!!Step: %d!!!Epsilon: %.2f!!!Osc. Step: %.2f!!!\n",k,l,1/l^2)
	deviation3(k) = deviation1(int8(100*l),k);
	deviation4(k) = deviation2(int8(100*l),k);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(1,2,1)
legend('W/O Stochastic Averaging','With Stochastic Averaging')
for index=100:10:100
	hold on
	%plot(X_axis,squeeze(position(1,100,:)),'LineWidth',2,'Color','m')
end
grid on;
xlabel('Walker position');
ylabel('Occupation probability');
title(['Probability vs Position for ', num2str(Number_Of_Steps), ' steps.'])

%subplot(1,2,1)
for index=100:10:100
	hold on
	plot(X_axis,squeeze(position(2,100,:)),'LineWidth',2,'Color','g')
end
grid on;
xlabel('Walker position');
ylabel('Occupation probability');
title(['Probability vs Position for ', num2str(Number_Of_Steps), ' steps with statistical averaging.'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,2)
for index=100:100
	hold on
	%plot(x,deviation1(index,:),'LineWidth',2,'Color','m')
end
grid on;
xlabel('Number of steps');
ylabel('SD');
legend('Taller = Smaller Epsilon','Location','northwest')
title(['SD vs #steps for ', num2str(Number_Of_Steps), ' steps.'])

%figure(5)
%subplot(1,2,1)
for index=100:10:100
	hold on
	plot(x,deviation2(index,:),'LineWidth',2,'Color','g')
end
grid on;
xlabel('#steps');
ylabel('\sigma');
legend('\epsilon = 0.01','\epsilon = 0.11','\epsilon = 0.21','\epsilon = 0.31','\epsilon = 0.41','\epsilon = 0.51','\epsilon = 0.61','\epsilon = 0.71','\epsilon = 0.81','\epsilon = 0.91','Location','northwest')
%title(['\sigma vs #steps for ', num2str(Number_Of_Steps), ' steps with statistical averaging.'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(1,2,1)
for index=1:100
	hold on
	plot(e,deviation1(:,1:10:index))
end
grid on;
xlabel('Epsilon');
ylabel('SD');
%ylim([0 Number_Of_Steps]);
legend('Taller = Bigger # of Steps')
title(['SD vs Epsilon for ', num2str(Number_Of_Steps), ' steps.'])

subplot(1,2,1)
for index=2:10:100
	hold on
	plot(e,deviation2(:,index),'LineWidth',2)
end
grid on;
xlabel('\epsilon');
ylabel('\sigma');
%ylim([0 Number_Of_Steps]);
legend('Taller = Bigger # of Steps')
legend('#steps = 1','#steps = 11','#steps = 21','#steps = 31','#steps = 41','#steps = 51','#steps = 61','#steps = 71','#steps = 81','#steps = 91','Location','northwest')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure (2);
%subplot(4,2,7)
subplot(1,2,2)
hold on
size(x)
size(y)
size(deviation3)
plot3(x,y,deviation3,'LineWidth',1.0,'Color','k')
%mesh(x,e,deviation1)
surfl(x,e,deviation1)
colormap(pink)    % change color map
shading interp    % interpolate colors across lines and faces
grid on;
xlabel('Number of steps');
zlabel('Standard deviation');
ylabel('Epsilon');
%legend('Taller = Smaller Epsilon','Location','northwest')
%title(['SD vs #steps vs epsilon for ', num2str(Number_Of_Steps), ' steps.'])

%subplot(4,2,8)
subplot(2,1,2)
hold on
plot3(x,y,deviation4+1,'LineWidth',1.0,'Color','k')
%mesh(x,e,deviation2)
surfl(x,e,deviation2)
colormap(pink)    % change color map
shading interp    % interpolate colors across lines and faces
grid on;
xlabel('Number of steps');
xlim();
zlabel('Standard deviation');
ylabel('Epsilon');
%legend('Taller = Smaller Epsilon','Location','northwest')
%title(['SD vs #steps vs epsilon for ', num2str(Number_Of_Steps), ' steps with statistical averaging.'])
