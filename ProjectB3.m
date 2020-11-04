function ProjectB3(V0, Q, maxtime, minT)
%ProjectB Solution written by Max Muss
%A function thgat takes an initial viral load (V0), drug effectiveness (Q), maximum
%time (maxtime) and minimum T-Cell Count (minT)and plots the Uninfected and
%Infected T-Cell Level as a function of time as well as the Viral Load as a
%function of time

days = 1; %Sets intial value for days = 1
T = 1; %Sets the intitial T-Cell Level to 1
I = 0; %Sets the intial infected T-Cell Level to 0
V = V0; %Intializes the viral load to V0

tArray = []; %Creates an array for the T values
iArray = []; %Creates an array for the I values
vArray = []; %Creates an array for the V values
t = []; %Creates an array for the time values (days)

while (days<=2500 & T+I>minT)t
    %Loop that calls the Increment subfunction until either the
    %maxtime is exceeded or the total T-cell count is less than minT.
    [Tnext(days), Inext(days), Vnext(days)] = Increment(T, I, V, Q);
    T=Tnext(days);
    I=Inext(days);
    V=Vnext(days);
    
    %After each increment, the day, T-cell count, infected
    %T-cell count and viral load are saved in memory.
    tArray(days) = T; 
    iArray(days) = I;    
    vArray(days) = V; 
    t(days) = days;
    
    days = days + 1; %Move to the next day
    if(days>2000)
        T=1;
        I=0;
        
end

while(Q>=.98 & t(length(t))>=2000 & t(length(t))<2500)
    T = 1;
    I = 0;
    
    tArray(days) = T; 
    iArray(days) = I;    
    vArray(days) = V; 
    t(days) = days;
    days = days + 1;
end

figure('Name','T-cells and Infect T-Cells vs. Time', 'NumberTitle','off'); %Creates figure with title "T cells and Infect Cells vs. Time"
plot(t, tArray); %Plots time (days) vs. T-Cells
hold; %Holds plot
plot(t, iArray); %Plots time (days) vs. Infected T-Cells
xlabel('Times (days)'); %Labels X-axis
ylabel({'T Cells', 'Infected Cells'}); %Labels Y-Axis
legend({'Uninfected','Infected'},'Location','northeast') %Adds legend to graph to label lines

figure('Name','Viral Load vs. Time', 'NumberTitle', 'off') %Creates figure with name "Viral Load vs. Time"
plot(t, vArray); %Plots time (days) vs. Viral Load
xlabel('Time (days)'); %Labels X-axis
ylabel('HIV Viral Cells'); %Labels Y-Axis

%Prints the Final Uninfected T-Cell Level, Infected T-Cell Level, Viral
%Load and days
fprintf('\tFinal Uninfected T-Cell Level: %f%% \n\tFinal Infected T-Cell Level: %f%% \n\tFinal Viral Load: %f \n\tFinal day: %f\n', ...
    tArray(length(tArray))*100, iArray(length(iArray))*100, vArray(length(vArray)), t(length(t)));
end
    
function Tnext = NewT(T,V)
    %A subfunction which takes the current day?s T-cell count and 
    %viral load and returns the T-cell count for the next day.
    Tnext = T -.001*T*V;
end

function Inext = NewI(T, I, V)
    %A subfunction which takes the current day?s T-cell count, 
    %viral load and count of infected T-cells and returns the 
    %infected T-cell count for the next day.
    Inext = I + .001*T*V -.005*I;
end

function Vnext = NewV(T, I, V, Q)
    %A subfunction which takes the current day?s T-cell count, 
    %viral load, count of infected T-cells and drug effectiveness
    %and returns the viral load on the following day.
    Vnext = V + 10*(1-Q)*I -.05*V*T;
end

function [Tnext,Inext,Vnext] = Increment(T, I, V, Q)
    %A subfunction that takes the T-cell count, the viral load
    %and the infected T-cell count and increments them all by one day.
    Tnext = NewT(T, V);
    Inext = NewI(T, I , V);
    Vnext = NewV(T, I, V, Q);
end
    