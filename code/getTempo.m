function tempo = getTempo(accel)
    % Build a low-pass filter on the data
    
    
    n = [-101:100];
    wc = 2/(2*pi);
    filt = wc/pi*sinc(wc*n/pi);
    
    times = accel(:,1) - accel(1,1);
    timestampsDesired = linspace(times(1), times(end), size(times,1));
    sampleRate = 1/(timestampsDesired(2) - timestampsDesired(1)); % Calculate the approximate sample rate
    xAccel = conv(accel(:,2), filt, 'same')
    yAccel = conv(accel(:,3), filt, 'same')
    zAccel = conv(accel(:,4), filt, 'same')

%     xAccel = conv(accel(timeIdx,2), filt, 'same');
%     yAccel = conv(accel(timeIdx,3), filt, 'same');
%     zAccel = conv(accel(timeIdx,4), filt, 'same');
    
    % Build the array of frequencies for the FFT
    freqs = linspace(-length(yAccel)/2,length(yAccel)/2-1+mod(length(yAccel),2),length(yAccel))*(sampleRate/length(yAccel));
    fftX = fftshift(fft(xAccel)); 
    fftY = fftshift(fft(yAccel)); 
    fftZ = fftshift(fft(zAccel)); 
    fftX(find(abs(freqs)<0.25)) = 0; % Filter out the constant term
    fftY(find(abs(freqs)<0.25)) = 0; % Filter out the constant term
    fftZ(find(abs(freqs)<0.25)) = 0; % Filter out the constant term
    
    
    [Mx, Ix] = max(fftX); % Find the index of the peak in the FFT
    [My, Iy] = max(fftY);
    [Mz, Iz] = max(fftZ);
    
%     freqX = abs(freqs(Ix));
%     freqZ = abs(freqs(Iz));
%     
%     guessFreq = freqX/freqZ;
%     display(guessFreq);
    
%     if (abs(guessFreq-2) < 0.02)
%         display('4/4');
%     elseif (abs(guessFreq-1) < 0.02)
%         display('3/4');
%     elseif (abs(guessFreq-1.5) < 0.02)
%         display('6/8');
%     end
    
    tempo = abs(freqs(Ix))*60; % Convert from index to bpm
    
%     figure(1);
%     clf;
%     
%     subplot(2,3,1);
%     plot(times,accel(:,2));
%     title('Time Domain - X')
%     xlabel('Time(s)')
%     ylabel('Amplitude(m/s2)')
%     subplot(2,3,4);
%     plot(freqs, abs(fftX));
%     xlim([-5 5])
%     title('Frequency Domain - X');
%     xlabel('Frequency(Hz)')
%     set(gca, 'XTick', [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5])
%     ylabel('Amplitude')
    
%     figure(2);
%     clf;
%     subplot(2,3,2);
%     plot(times,accel(:,3));
%     title('Time Domain - Y')
%     xlabel('Time(s)')
%     ylabel('Amplitude(m/s2)')
%     subplot(2,3,5);
    plot(freqs, abs(fftX), 'LineWidth', 1.5);
    hold on;
    display(freqs(Ix));
    disp(abs(Mx));
    plot(freqs(Ix),abs(Mx), 'r*');
    xlim([-5 5])
    ylim([0 20000]);
    set(gca, 'XTick', [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5], 'FontSize', 14)
    title('Prominence of Frequencies in y-acceleration @ 120 BPM','FontSize', 20);
    xlabel('Frequency(Hz)', 'FontSize', 20)
    ylabel('Amplitude', 'FontSize', 20)
  
%     figure(3);
%     clf;
%     subplot(2,3,3);
%     plot(times,accel(:,4));
%     title('Time Domain - Z')
%     xlabel('Time(s)')
%     ylabel('Amplitude(m/s2)')
%     subplot(2,3,6);
%     plot(freqs, abs(fftZ));
%     xlim([-5 5])
%     title('Frequency Domain - Z');
%     xlabel('Frequency(Hz)')
%     set(gca, 'XTick', [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5])
%     ylabel('Amplitude')
end