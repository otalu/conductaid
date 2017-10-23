function data = streamData(m)
   if (m.Logging == true)
       [accelData, times] = m.accellog;
       curTime = times(end);
       indices = find(times-curTime > -3);
       accelVals = accelData(indices, 1:3);
%        set(plotOut,'XData',times(indices),'YData',accelVals(:,1));
%        drawnow;
       data = [times(indices), accelVals];
   else
       data = nan;
   end    
end