function [volume, Fs] = getVolume(dataset)
    
    frequency = 1;
    [Fs, filtered] = low_pass(dataset, frequency);
    volume_x = abs(real(give_volume2(filtered(:,1), Fs)));
    volume_y = abs(real(give_volume2(filtered(:,2), Fs)));
    volume_z = abs(real(give_volume2(filtered(:,3), Fs)));
    volume = sqrt(volume_x^2 + volume_y^2 + volume_z^2);

    function [Fs, filtered] = low_pass(dataset, frequency)
        t = dataset(:,1);
        dataset(:,4) = dataset(:,4)-9.81;
        
        ax = dataset(:,2);
        ay = dataset(:,3);
        az = dataset(:,4);
        
        cutoff = 1.1 * frequency;
        n = [-42:41];
        wc = cutoff/(2*pi);
        lpf = wc/pi*sinc(wc*n/pi);
        Fs = round(1/(t(2) - t(1)));
        
        filtered_x = conv(ax, lpf, 'same');
        filtered_y = conv(ay, lpf, 'same');
        filtered_z = conv(az, lpf, 'same');
        filtered = [filtered_x, filtered_y, filtered_z];
        
    end

    function volume = give_volume(accel, Fs)
       accel = abs(accel - mean(accel));
       volume = findpeaks(accel);
       ipt = findchangepts(accel, 'MaxNumChanges', 1, 'Statistic', 'rms');
       if ipt
           volume = findpeaks(accel(ipt:end, 1));
       end
    end

    function volume = give_volume2(accel, Fs)
        FFTaccel = fftshift(fft(accel));
        range = linspace(-Fs/2, Fs/2 - Fs/size(FFTaccel, 1), size(FFTaccel, 1));
        transformed = [range', FFTaccel];

        idx = find(abs(range)<0.25);
        transformed(idx, 2) = 0;
%         plot(range, real(transformed))
        volume = max(transformed(:,2));
    end
end