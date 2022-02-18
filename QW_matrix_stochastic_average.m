function [position, deviation] = QW_avrg(Number_Of_Steps, Number_Of_Dimensions, V_q1, V_q2, coin_walker_density)

position = zeros(1,2*Number_Of_Dimensions+1);
deviation = zeros(1,Number_Of_Dimensions);

for index=1:Number_Of_Steps
	coin_walker_density = 0.5*(V_q1*coin_walker_density*V_q1'+V_q2*coin_walker_density*V_q2');

	%%%%%%%%%%%%%%%%%% Calculate Deviation %%%%%%%%%%%%%%%%%
	mean_value = 0;
	deviation_temp = 0;

	for k=1:(2*Number_Of_Dimensions+1)
	    deviation_temp = deviation_temp+position(1,k)*(-Number_Of_Dimensions+k-1)^2;
	end

	deviation(1,index) = sqrt(deviation_temp);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Decoupling with partial trace
	position = abs(real(diag(TrX(coin_walker_density,1,[2 2*Number_Of_Dimensions+1]))))';
end
