%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Init for ε E (0,1) (mixed diffusion)         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(1,2,1)
e = 1;
e_index=e*e_total;
hold on
for x=1:e_total
	plot(X_axis,p_nk(e_index,:),'LineWidth',1)
legend('#steps = 10','#steps = 20','#steps = 50','#steps = 100','Location','northeast','FontSize',14)
end
xlabel('Walker Position');
ylabel('Occupation Probability');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ARISTERA EINAI TO EPISLON
% DEKSIA EINAI TO N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,2)
hold on
plot(X_axis_positive,deviation(1,:))
xlabel('walker step')
ylabel('SD')
hold off
%
subplot(1,2,2)
