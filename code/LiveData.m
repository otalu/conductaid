clf;
tempos = [0];
val = 1;

prev_vol = 1;
vol_mat = [0];


% Setup window
h = figure(1);
set(h,'MenuBar','none','ToolBar','none');
pnt = plot(0.32,0.5,'r.', 'MarkerSize', 200);
hold on;
axis([0 1 0 1]);
lineOut = plot([0.5, 1.5],[.945, .945], 'LineWidth',20);
volVal = plot(0.5, .945, 'k.', 'MarkerSize', 130);
tempoOut = text(-.12, 0, 'Tempo: BPM');
volText = text(.65, .8, '0');
volOut = text(-.12,.95,'Volume');
beatOut = text(-.12, .5,'Cue:');

axis off;
set(tempoOut,'FontSize',50);
set(beatOut,'FontSize',50);
set(volOut,'FontSize',50);
set(volText,'FontSize',20);



while (true)
    accelData = streamData(m);
    if (~isnan(accelData))
%         set(plotOut,'XData',accelData(:,1),'YData',accelData(:,2));
        drawnow;
        tempos(val) = getTempo(accelData);
        [volumeOut, Fs] = getVolume(accelData);
        vol_mat(val) = volumeOut;
        val = val + 1;
        if (val > 250)
            tempo = uint16(mean(tempos(end-249:end)));
            ave_vol = mean(vol_mat(end-249:end));
            set(tempoOut,'String',strcat('Tempo: ',num2str(tempo),' BPM'));
            set(volVal, 'XData', .5+(ave_vol/2200));
            set(volText, 'String', num2str(ave_vol));

        end

%         display(tempo)
        beat = getPeaks(accelData);
        if (beat == true)
            set(pnt,'Color', 'g');
        else
            set(pnt,'Color', 'r');
        end
        
        [volume, Fs] = getVolume(accelData);
%         if numel(vol_mat) < 100
%             vol_mat = [vol_mat; volume];
%             prev_vol = ave_vol;
%             ave_vol = rms(vol_mat);
%         else
%             vol_mat = [];
%             ave_vol = prev_vol;
%         end
        
        
%         disp(ave_vol)
    end
end
