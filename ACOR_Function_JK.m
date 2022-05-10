function ObjVal = ACOR_Function_JK(BestPosition)      
%% BestPositionrite into input .sp file
           
          
           WfidIn=fopen('C:\Users\farshid\Documents\MATLAB\JK.sp','r+');
           ach=fread(fidIn);
           pchar=char(ach');
           
           pos=strfind(pchar,'MN1');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(1));   
           
           pos=strfind(pchar,'MN2');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(2));   
           
           pos=strfind(pchar,'MN3');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(3));   
           
           pos=strfind(pchar,'MN4');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(4));   
           
           pos=strfind(pchar,'MN5');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(5));   
           
           pos=strfind(pchar,'MN6');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(6));   
           
           pos=strfind(pchar,'MN7');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(7));   
           
           pos=strfind(pchar,'MN8');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(8));   
           
           pos=strfind(pchar,'MP1');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(9));   
           
           pos=strfind(pchar,'MP2');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(10));  
           
           pos=strfind(pchar,'MP3');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(11));   
           
           pos=strfind(pchar,'MP4');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(12));   
           
           pos=strfind(pchar,'MP5');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(13));   
           
           pos=strfind(pchar,'MP6');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(14));   
           
           pos=strfind(pchar,'MP7');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(15));   
           
            pos=strfind(pchar,'MP8');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(16));   
           
            pos=strfind(pchar,'MN9');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(17));   
           
            pos=strfind(pchar,'MNN');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(18));   
           
           
            pos=strfind(pchar,'MP9');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(19));   
           
            pos=strfind(pchar,'MPP');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(20));
           
                         
           fclose('all');
           
%% run hspice 
            !C:\synopsys\Hspice_D-2010.03-SP1\BIN\hspice.exe  -i C:\Users\farshid\Documents\MATLAB\JK.sp   -o C:\Users\farshid\Documents\MATLAB\JK
            
%% read data from .lis file 
           
           fidout=fopen('C:\Users\farshid\Documents\MATLAB\JK.lis','r+');
           B=fread(fidout);
           so = char(B');       
           
           pos=strfind(so,'avgpower');
           fseek(fidout,pos(1)+11,'bof');
           ObjVal=fscanf(fidout,'%f');
              
                   
           fclose('all'); 
           
end   
% End of function