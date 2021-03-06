
%% Example to use the various sontrol modes of vrep_interface
close all;
clear all;clc

robot_init = [0 0 0];
sim = vrep_interface();
fprintf('Do you want to turn "on" the control mode or want it to remain "off" ?\n Enter "1" to turn on or "0" to keep it off\n');
controlMode = input('Enter Choice : ');
sim = sim.simInitialize(controlMode);
if(controlMode==1)
    fprintf('Enter the control mode type\nEnter "1" for Kinematic or "2" for Dynamic\n');
    modeType = input('Enter Choice : ');
else modeType = 0;
end
sim = sim.SetRobot(robot_init,modeType);

fprintf('Starting simulation\n');
figure
for i = 1:100
    i
    sim = sim.getSensorData;
    laserData = squeeze(sim.sensor.laserData);
    idx = find(abs(laserData(1,:))<10 & abs(laserData(2,:))<10);
    laserData = laserData(:,idx);
    plot(laserData(1,:),laserData(2,:),'.r')
    sim = sim.evolve([0.2 0]); %% Input linear velocity in m/s & angular velocity in rad/s
end

sim = sim.delete();





