clf;
% plotOut = plot(1,0, 'r*');
% axis([0 2 0 2]);
% s = load('gong');
tempos = [0];
val = 1;

% h = figure(1);
% set(h,'MenuBar','none','ToolBar','none');
% pnt = plot(0.5,0.5,'r.', 'MarkerSize', 200);
% textOut = text(0.5, 0, 'test');
% axis off;
% set(textOut,'FontSize',50);

while (true)
    accelData = streamData(m);
    if (~isnan(accelData))
%         set(plotOut,'XData',accelData(:,1),'YData',accelData(:,2));
%         drawnow;
        tempos(val) = getTempo(accelData);
        val = val + 1;
        if (val > 250)
            tempo = uint16(mean(tempos(end-249:end)));
            set(textOut,'String',num2str(tempo));

        end

%         display(tempo)
%         beat = getPeaks(accelData);
%         if (beat == true)
%             set(pnt,'Color', 'g');
%         else
%             set(pnt,'Color', 'r');
%         end
    end
end