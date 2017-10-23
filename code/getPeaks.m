function isBeat = getPeaks(accel)
    % Build a low-pass filter on the data
    n = [-42:41];
    wc = 3/(2*pi);
    filt = wc/pi*sinc(wc*n/pi);
    
    allTimes = accel(:,1) - accel(1:1);
    xAccel = conv(accel(:,2), filt, 'same');
    yAccel = conv(accel(:,3), filt, 'same');
    zAccel = conv(accel(:,4), filt, 'same');
    
    [peakX,locX] = findpeaks(xAccel, 'MinPeakProminence',10);
    xMean = mean(peakX);
    [peakY,locY] = findpeaks(-yAccel, 'MinPeakProminence',20);
    yMean = mean(peakY);
    [peakZ,locZ] = findpeaks(zAccel, 'MinPeakProminence',10);
    
    if (~isnan(locY))
        if (allTimes(end) - allTimes(locY(end)) < .25)
            isBeat = true;
        else
            isBeat = false;
        end
    else
        isBeat = false;
    end
    clf;
%     subplot(3,1,1);
%     plot(allTimes, xAccel);
%     hold on
%     plot(allTimes(locX),peakX, 'r*');
%     plot([allTimes(1) allTimes(end)],[xMean xMean], 'k-');
%     subplot(3,1,2);
    plot(allTimes, -yAccel, 'LineWidth', 2);
    hold on
    plot(allTimes(locY),peakY, 'r*');
    ylim([-5 22]);
    title('Cue Detection','FontSize', 20);
    set(gca, 'FontSize', 14)
    xlabel('Time (s)', 'FontSize', 20)
    ylabel('Y-axis Acceleration (m/s^2)', 'FontSize', 20)
%     subplot(3,1,3);
%     plot(allTimes, zAccel);
%     hold on
%     plot(allTimes(locZ),peakZ, 'r*');

    
    
end