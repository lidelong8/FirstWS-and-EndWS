function [ToE,ToD]=EndWS(tmp,threshold)
   %%tmp:the nx1 or 1xn time series
   %% water scarcity threshold
   %%ToE: the first year when per-capita water availability at the grid scale is below a threshold for at least five consecutive years between 1901 to 2090
   %%ToD: the first year of water scarcity relieved and whose scarcity-free situation (i.e., above the threshold) lasts until 2090
   %%
   startyear=1900;%the first year of the time series
   endyear=2100;%the last year of the time series
   lag=5; % here represent water scarcity last at least 5 year
   
    %indentify FirstWS
    id=find(tmp<threshold); %find water scarcity id
    matrix_data=zeros(size(tmp));
    matrix_data(tmp<threshold)=1;
    flickers=diff(matrix_data);  %1 from safe to risk; -1 from risk to safe
    flicker=find(flickers==-1);

    if length(find(~isnan(tmp)))>100 % more than 100 useful data, then process
        mark=0;
        if ~isnan(id)  %if there is at least a year encountering water scarcity, then calculate FirstWS
          for yr=1:length(id)
             if id(yr)<=length(tmp)-lag %Origional series 1900-2099 (201year) only consider 2090
                   if all(matrix_data(id(yr):id(yr)+lag-1)==1) %
                       ToE=id(yr)+startyear-1;
                       mark=1;
                       break
                   end
             else 
                    if all(matrix_data(id(yr):end)==1) %% last to endyear (last less than 5 yr)
                       ToE=id(yr)+startyear-1; %
                       mark=1;
                       break
                   end
             end
          end    %end for yr
          %%must notecify that if only 1-4 year scarcity, the results is nan
            if mark==0
               ToE=9998; %There are some years water scarcity, but not last at least 5 year
            end
        else  %always safe
             ToE=9999; %%Never water scarcity
        end      
       %indentify FirstWS

       %indentify EndWS 
        if mark==0  % if there is no FirstWS, mean that there is never water scarcity, ignore the EndWS, we defined as 1900 (or Nan)
           ToD=startyear;            
        else  %mark~=1, mean that there is FirstWS, then loop to calculate EbdWS
            if ~isnan(flicker)  %
                mark2=0;
                for yr=1:length(flicker)
                    if flicker(yr)>=lag & flicker(yr)<=185 %only consider >5 year water scarcity
                        if all(matrix_data(flicker(yr)+1:end-9)==0) %last to 2090, so minus 9
                            ToD=flicker(yr)+startyear-1+1; %diff minus one number,so add one.
                            mark2=1;
                            break
                        end
                    elseif flicker(yr)>185 & flicker(yr)<=190  %We only consider the periods up to 2090
                        if all(matrix_data(flicker(yr)+1:flicker(yr)+lag)==0)
                            ToD=flicker(yr)+startyear-1+1; %diff minus one number,so add one.
                            mark2=1;
                            break
                        end
                    end %end if
                end  %end for
                if mark2==0
                    ToD=9998; %Not fully disappearing
                end
            else
                ToD=9999; %Never disappearing
            end   %end  if   
       end %
       %indentify EndWS

    end % more than 100 useful data
