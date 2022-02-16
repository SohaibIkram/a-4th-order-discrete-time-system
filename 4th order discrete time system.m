%% Signals Project
%Submitted By:
% Muhammad Yousuf Channar 306331 BEE 11 A
% Muhammad Sohaib Ikram 283756 BEE 11 A
%% Here we are constructing the z domain equations then we will further use them for DTFT and time domain
%constructing the vectors of coefficients invlolved in H1(z) and H2(z)
%Our Equation of the bandpass filter was
%      H1(z)= z.^2./(z.^2-1.3753*z+0.7225)
%So the vector of coefficients are:
a1 = [1 -1.3753 0.7225];
b1 = [1 0 0];
%Our Response for the band stop filter was 
% H2[z]=(z.^2+0.6180*z+1)./z.^2
% Hence our vectors are:
a2 = [1 0 0];
b2 = [1 0.6180 1];
%The Filt function of the MATLAB will convert these vectors into discrete
%time system functions
%this will give us pole zero plots on a unit circle in MATLAB
t1 = filt([1 0 0],[1 -1.3753 0.7225],'variable','z')
t2 = filt([1 0.6180 1],[1 0 0],'variable','z')

%======================================================================================

%% Plotting the Pole zeros in the below part
figure(1)
pzmap(t1)
title('Pole-Zero Plot of 2nd Order Bandpass Filter')
%Here We are changing the linewidth and marker size of poles and zeros to make them visible
polezeros= findobj(gca, 'Type', 'Line');
for i = 1:length(polezeros)
    set(polezeros(i),'markersize',12) %change marker size
    set(polezeros(i), 'linewidth',2)%change linewidth
    set(polezeros(i),'color','r')%change color
end
zgrid
%============================================================================
figure(2)
pzmap(t2)
title('Pole-Zero Plot of 2nd Order Bandstop Filter')
polezeros= findobj(gca, 'Type', 'Line');
for i = 1:length(polezeros)
    set(polezeros(i),'markersize',12) %change marker size
    set(polezeros(i), 'linewidth',2)  %change linewidth
    set(polezeros(i),'color','g')
end
zgrid
%% In this part we are going to plot the discrete time plots of the impulse responses of systems
figure(3)
subplot(211)
% the impz function converts the coefficient vectors of the frequency
% response to the impulse responses of the system
%hence here we are evaluating the impulse responses as well as plotting
%them
impz(b1,a1) 
title('H1[n]')
subplot(212)
impz(b2,a2)
title('H2[n]')
%% This part is dedicated to the Frequency plots of the systems
figure(4)
%defining the limits of z
w=linspace(0,pi);
r=1;
%converting z to Fourier Transform
z=r*exp(1i*w);
%Here we are having the Frequency responses of the system 
%first we plot them and then multiply them to make them equivalent to
%cascading in the time domain
%frequency response of band pass filter with peak value of 3
bandpass=(z.^2./(2*(z.^2-1.3752*z+0.7225)));
subplot(311)
stem(w,bandpass,'c')
title('Frequency Response of Bandpass Filter')
subplot(312)
bandstop=((z.^2+0.6180*z+1)./(2.26*z.^2));
stem(w,bandstop,'m')
title('Frequency Response of Bandstop Filter')
subplot(313)
system=1+(bandstop.*bandpass);
stem(w,system)
title('Frequency Response of Cascaded System')

%% Calculating the RMS Difference
idealresponse=1*(w>=0)+2*(w>=0.1*pi)-2*(w>=0.3*pi)-1*(w>=0.5*pi)+1*(w>=0.7*pi);
designedresponse=system;
figure(5)
subplot(211)
stem(w,idealresponse,'r');
title('Frequency Response of Ideal System')
subplot(212)
stem(w,designedresponse,'g');
title('Frequency Response of Designed System')
N=length(w);
H_difference = (sqrt((sum((abs(idealresponse) - abs(designedresponse)).^2)/N)))