%% Project Details
% Name :                Tomo Emmanuel Adegboyega
% Date:                 April 3rd 2023
% Company:              Han University of Applied Sciences
% Education:            Master Engineering Systems
% Student Number:        2103826
% Module: Practice Modelling and Simulation
clear all
close all
clc

% electrical
%cu=            %Motor's armature current [A]
R = 0.03               %Armature resistance  [ohms]
L =2.5  * (10^-3)                   %Armature inductance  [H]
Kb =0.35            %Back-emf constant [ V.s/rad]

% mechanical
J = 0.5 * (10^-2)  %Moment of inertia of the shaft and load [ N.m2].
Kt = 0.9              %Motor's torque constant [Nm/A].
B = 0.24             %Bearing's friction coefficient [Nm.s/rad].
i = 0.2                % transmission ratio
r = 0.3                %dynamic wheel radius [m]
K=Kb
                
% Road load
W= 45            %rolling resistance [kg.m/s2].
X = 0.46         %[kg/m] 
Y = 300          %mass [kg].
Z =3000        %weight [ N] 
alpha = 0            %slope angle [rad]
%FL =               %load force [N].
%%Scenario1
v = 0              %vehicle velocity [m/s].
vo = 48                  % Motor's input voltage [V]

%% Continous time transfer function
s = tf('s');
P_motor =Kt/(s*((J*s+B)*(L*s+R)+Kb*Kt))
%% continous time State space
A3 = [0 1 0
    0 -B/J Kt/J
    0 -Kb/L -R/L];
B3 = [0 ; 0 ; 1/L];
C3 = [0 1 0];
D3 = [0]
motor_ss = ss(A3,B3,C3,D3);
%% Plot transfer function
velocity= 4
slope=1
sim_time=1
sim("EM1.slx")
figure()
plot(tout,InputVoltage)
hold on
plot(tout,TFmotor) 
title('Transfer function')
legend('InputVolatage','Transfer function Angular speed[rad/s]')
xlabel('time [s]')
ylabel('Angular speed[rad/s]')
grid on
hold off

%% Plot Statespace
velocity= 4
slope=1
sim_time=1
sim("EM1.slx")
figure()
plot(tout,InputVoltage)
hold on
plot(tout,SSmotor) 
title('StateSpace')
legend('InputVolatage','SS Angular speed[rad/s]')
xlabel('time [s]')
ylabel('Angular speed[rad/s]')
grid on
hold off

%% Model Response
velocity= 4
slope=1
sim_time=1
sim("EM1.slx")
figure()
plot(tout,InputVoltage)
hold on
plot(tout,Speed)
hold on 
plot(tout,current)
title('Model Equation Behaviour')
legend('InputVoltage','Angular speed[rad/s]','Current[A]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off

%% Compare Differential equation ,transfer function and Statespace
velocity= 4
slope=1
sim_time=1
sim("EM1.slx")
figure()
plot(tout,InputVoltage,'b')
hold on
plot(tout,TFmotor,'--g','LineWidth',2) 
hold on
plot(tout,Speed,'r')
hold on 
plot(tout,SSmotor,'.b')
title('Compare Differential equation, transfer function and Statespace')
legend('InputVoltage','Transferfunction ','Model equation','Statespace')
xlabel('time [s]')
ylabel('Angular speed[rad/s]')
grid on
hold off

%% Scenario1
velocity= 1
slope=1
sim_time=0.4
sim("EM1.slx")
figure()
plot(tout,InputVoltage)
hold on
plot(tout,Speed)
hold on 
plot(tout,current)
title('Model Behaviour Scenario1')
legend('InputVoltage','Angular speed[rad/s]','Current[A]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off
%% Scenario2
velocity= 2
slope=2
sim_time=3.0
sim("EM1.slx")
figure()
plot(tout,InputVoltage)
hold on
plot(tout,Speed)
hold on 
plot(tout,current)
title('Model Behaviour Scenario2')
legend('InputVoltage','Angular speed[rad/s]','Current[A]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off
%% Scenario3
velocity= 3
slope=1
sim_time=5.0
sim("EM1.slx")
figure()
plot(tout,InputVoltage)
hold on
plot(tout,Speed)
hold on 
plot(tout,current)
title('Model Behaviour Scenario3')
legend('InputVoltage','Angular speed[rad/s]','Current[A]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off

%% Import & select measured data
validate= readmatrix("InputOutputData.xlsx");
xx=validate(:,1);                    %   Time[s]
xx=xx(1:1000);
yy=validate(:,5);                   %    Current[A]
yy=yy(1:1000);
zz=validate(:,6);                   %     Angular speed[rad/s]
zz=zz(1:1000);
figure()
plot(xx,zz)
hold on 
plot(xx,yy)
title('Measured data')
legend('Angular speed[rad/s]','Current[A]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off
%% Model Validation
velocity= 4
slope=1
sim_time=1
sim("EM1.slx")
figure()
plot(tout,Speed)
hold on
plot(xx,zz)
hold off
title('Model speed validation')
legend('Simulated Angular speed[rad/s]','Measured Angular speed[rad/s]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off

figure()
plot(tout,current)
hold on 
plot(xx,yy)
title('Model current validation')
legend('Simulated current[A]','Measured current[A]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off
%% Scenario1 VALIDATION
velocity= 1
slope=1
sim_time=1
sim("EM1.slx")
figure()
plot(tout,Speed)
hold on
plot(xx,zz)
hold off
title('Scenario1 speed validation')
legend('Simulated Angular speed[rad/s]','Measured Angular speed[rad/s]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off

figure()
plot(tout,current)
hold on 
plot(xx,yy)
title('Scenario1 current validation')
legend('Simulated current[A]','Measured current[A]')
xlabel('time [s]')
ylabel('System Outputs')
grid on
hold off
%%  Sensitivity Analysis
%Defining the parameters for the loop(one at a time)
J = J:0.05:(J+0.5); % 10% Increase moment of inertia of inner gimbal in kgm2
n = length(J); % Size of the change vector
% Iterations
for i=1:1:n
    u=J(i); %  moment under consideration[kgm2]
    B=0.24; % Damping coefficient in [Nms/rad]
    i= 0.2; % spring constant [Nm/rad]
    %%simulate the model
    sim_time=1
    sim('EMJ1.slx')
    %%plot the results
    figure(10)
    plot(tout,Speed); % plot to workspace variable of choice
    hold on;
end
figure(10)
hold off; 
title('J-Sensitivity analysis')
legend('Angular speed[rad/s]')
xlabel('time [s]')
ylabel('Angular speed[rad/s]')
grid on;

%Defining the parameters for the loop(one at a time)
B = B:0.05:(B+0.5); % 10% Increase moment of inertia of inner gimbal in kgm2
n = length(B); % Size of the change vector
% Iterations
for i=1:1:n
    u=B(i); %  moment under consideration[kgm2]
   J = 0.5 * (10^-2); % Damping coefficient in [Nms/rad]
    i= 0.2; % spring constant [Nm/rad]
    %%simulate the model
       sim_time=1
    sim('EMB1.slx')
    %%plot the results
    figure(11)
    plot(tout,Speed); % plot to workspace variable of choice
    hold on;
end
figure(11)
hold off; 
title('B-Sensitivity analysis')
legend('Angular speed[rad/s]')
xlabel('time [s]')
ylabel('Angular speed[rad/s]')
grid on;

%Defining the parameters for the loop(one at a time)
i = i:0.05:(i+0.5); % 10% Increase moment of inertia of inner gimbal in kgm2
n = length(i); % Size of the change vector
% Iterations
for p=1:1:n
    u=i(p); %  moment under consideration[kgm2]
   J = 0.5 * (10^-2); % Damping coefficient in [Nms/rad]
   B=0.24; % spring constant [Nm/rad]
    %%simulate the model
       sim_time=1
    sim('EMI1.slx')
    %%plot the results
    figure(12)
    plot(tout,Speed); % plot to workspace variable of choice
    hold on;
end
figure(12)
hold off; 
title('i-Sensitivity analysis')
legend('Angular speed[rad/s]')
xlabel('time [s]')
ylabel('Angular speed[rad/s]')
grid on;
