clc;
clear;
close all;
tic;
%% Problem Definition

CostFunction=@(BestPosition) ACOR_Function_JK(BestPosition)
%CostFunction=@(x) SphereFunction(x);        % Cost Function

nVar=20;             % Number of Decision Variables

VarSize=[1 nVar];   % Variables Matrix Size

VarMin=0.2;         % Decision Variables Lower Bound
VarMax= 2;         % Decision Variables Upper Bound

%% ACOR Parameters

MaxIt=100;          % Maximum Number of Iterations

nPop=30;            % Population Size (Archive Size)

nSample=10;         % Sample Size

q=0.6;              % Intensification Factor (Selection Pressure)
% q = Q , if COst is high or lenth of way is long so tau or Q or q is lows,
% q is individual factor

zeta=1;             % Deviation-Distance Ratio
% alpha is better to be "1" , it is the same as zeta , so zeta and alpha
% social factor or deviation ratio
%% Initialization

% Create Empty Individual Structure
empty_individual.Position=[];
empty_individual.Cost=[];

% Create Population Matrix
pop=repmat(empty_individual,nPop,1);

% Initialize Population Members
for i=1:nPop
    
    % Create Random Solution
    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Evaluation
    pop(i).Cost=CostFunction(pop(i).Position);
    
end

% Sort Population
[~, SortOrder]=sort([pop.Cost]);
pop=pop(SortOrder);

% Update Best Solution Ever Found
BestSol=pop(1);

%%
% Update Worst Solution Ever Found
WorstSol=pop(nPop);

%%

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

%%

% Array to Hold Worst Cost Values
WorstCost=zeros(MaxIt,1);

%%

% Solution Weights
w=1/(sqrt(2*pi)*q*nPop)*exp(-0.5*(((1:nPop)-1)/(q*nPop)).^2);

% Selection Probabilities
p=w/sum(w);


%% ACOR Main Loop

for it=1:MaxIt
    
    % Means
    s=zeros(nPop,nVar);
    for l=1:nPop
        s(l,:)=pop(l).Position;
        
        flag=(pop(l).Position<VarMin | pop(l).Position>VarMax);
                
        pop(l).Position=min(max(pop(l).Position,VarMin),VarMax);
        
        pop(l).Cost=CostFunction(pop(l).Position);
        
        
    end
    
    % Standard Deviations
    sigma=zeros(nPop,nVar);
    for l=1:nPop
        D=0;
        for r=1:nPop
            D=D+abs(s(l,:)-s(r,:));
        end
        sigma(l,:)=zeta*D/(nPop-1);
    end
    
    % Create New Population Array
    newpop=repmat(empty_individual,nSample,1);
    for t=1:nSample
        
        % Initialize Position Matrix
        newpop(t).Position=zeros(VarSize);
        
        % Solution Construction
        for i=1:nVar
            
            % Select Gaussian Kernel
            l=RouletteWheelSelection(p);
            
            % Generate Gaussian Random Variable
            newpop(t).Position(i)=s(l,i)+sigma(l,i)*randn;
            
        end
        
        % Evaluation
        newpop(t).Cost=CostFunction(newpop(t).Position);
        
    end
    
    % Merge Main Population (Archive) and New Population (Samples)
    pop=[pop
         newpop];
     
    % Sort Population
    [~, SortOrder]=sort([pop.Cost]);
    pop=pop(SortOrder);
    
    % Delete Extra Members
    pop=pop(1:nPop);
    
    %%
    % Update Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;
    
    %%
    % Update Worst Soultion Ever Found
    WorstSol=pop(nPop);
    % Store Worst Cost
    WorstCost(it)=WorstSol.Cost;
    WorstCost=max(WorstCost(it),pop(nPop).Cost);

    %%   
        
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    
 %% 1. Normalization of FIS Inputs
 itnormalized = it / MaxIt;
 
 Bestnormalized =  ( WorstCost - BestCost(it) ) / WorstCost
  
 %% 2. Read FIS file
 FISMAT = readfis('Fuzzy_ACOR_FIS.fis');
 
 %% 3. Define Input Arguments for FIS Before Firing Rules
 U = [itnormalized , Bestnormalized];
  
 %% 4. Fire Rules or Run Evalfis Command
 Y = evalfis(U,FISMAT);
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Fitness = Best Average Power');
toc;
