%###file superseded
% % clear all
% % close all
% % clc
% % nPi=10;
% % n=1;
% % count=0;
% % delimiterIn = ' ';
% % % nginxpi = {"2145","2146","2147","2148","2149";...
% % %             "2139","2140","2141","2142","2143";...
% % %             "2141","2142","2143","2144","2145";...
% % %             "2119","2120","2121","2122","2123";...
% % %             "2131","2132","2133","2134","2135";...
% % %             "2135","2136","2137","2138","2139";...
% % %             "2139","2140","2141","2142","2143";...
% % %             "2135","2136","2137","2138","2139";...
% % %             "2137","2138","2139","2140","2141";...
% % %             "2139","2140","2141","2142","2143"};
% %         
% % nginxpi = {"2824","2825","2826","2827","2828";...
% %             "2828","2829","2830","2831","2832";...
% %             "2137","2138","2139","2140","2141";...
% %             "2801","2802","2803","2804","2805";...
% %             "2833","2834","2835","2140","2141";...
% %             "2829","2830","2831","2832","2833";...
% %             "2846","2847","2848","2849","2850";...
% %             "2831","2832","2833","2834","2835";...
% %             "2829","2830","2831","2832","2833";...
% %             "2801","2802","2803","2804","2805"};
% %         
% % % for i = 0:10
% % %     for j = 0:(5)%number of process ID's per nginx.
% % %         %count=count+1;
% % %         %filename = sprintf('/home/joseph/Dropbox/rpi_testbed/0k-1stpi/htop-i%dPI%d.txt',i,j);
% % %         filename = sprintf('/home/joseph/Dropbox/rpi_testbed/pis_0k_baremetal/pi1/' + nginxpi(1) +'htop-i%dPI%d.txt',i,j);
% % %         %filedata{count} = readtable(filename);
% % %         filedata(1,1)
% % %         %T{count} = sortrows(table2array(filedata(count)),[1 4]);
% % %     end
% % % end
% % % count=0'
% % % for p = 0:3
% % %     for it = 0:3
% % %         count=count+1;
% % %         %count
% % %         %fprintf('pi= %d. Iteration= %d \n' , p,it);
% % %         %disp('and from the loop function')
% % %         getPiData(p,it);
% % %         %disp('end function')
% % %     end
% % % end
% % 
% % getPiData2(9,9)
% % 
% % 
% % % a=getData(1,1)
% % % function filedata = getData(i,j)
% % %     nginxpi = ["2145","2146","2147","2148","2149";...
% % %                 "2139","2140","2141","2142","2143";...
% % %                 "2141","2142","2143","2144","2145";...
% % %                 "2119","2120","2121","2122","2123";...
% % %                 "2131","2132","2133","2134","2145";...
% % %                 "2135","2136","2137","2138","2149";...
% % %                 "2139","2140","2141","2142","2143";...
% % %                 "2135","2136","2137","2138","2139";...
% % %                 "2137","2138","2139","2140","2141";...
% % %                 "2139","2140","2141","2142","2143"];
% % %     count=0;
% % %     for i1 = 0:10
% % %         for j1 = 0:5
% % %             count=count+1;
% % %             filename = sprintf("/home/joseph/Dropbox/rpi_testbed/pis_0k_baremetal/pi"+num2str(i)+"/" + nginxpi(i,j) +"htop-i%dPI%d.txt",i,j);
% % %             filedata{count} = readtable(filename);
% % %         end
% % %     end
% % % end
% % 
% % % function pi = getPiData(k)
% % %     getPiData=k;
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 