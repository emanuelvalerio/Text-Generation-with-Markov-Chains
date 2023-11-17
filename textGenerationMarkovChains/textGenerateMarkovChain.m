
% Emanuel Valerio Pereira

chapters=('3gab.txt'); % loading the chapters 

% database preprocessing
str = readlines(chapters);
filteredText = lower(strtrim(str(~cellfun('isempty', str))));
filteredText = strrep(filteredText, '"', '');
filteredText = regexprep(filteredText, '[.,!?;:-]', '');
shortText = strjoin(filteredText, ' ')';
textTerm= strsplit(shortText);

% Convert the cell array to a categorical array
states = categorical(textTerm);

% Create a transition matrix
unique_states = categories(states);
num_states = numel(unique_states);
transition_matrix = zeros(num_states);

% Count transitions
for i = 1:(numel(states) - 1)
    current_state = find(unique_states == states(i));
    next_state = find(unique_states == states(i + 1));
    transition_matrix(current_state, next_state) = transition_matrix(current_state, next_state) + 1;
end

% Transition probability
transition_matrix = transition_matrix ./ sum(transition_matrix, 2);

numberWords = 5; % number of words that will be generate
initialWord = '';
text = 'the';
initialWord = "the"; 

    for j=1:numberWords
            initialIdx = find(unique_states==initialWord);
            possibleState = states(find(transition_matrix(initialIdx,:)~=0));
            probabilitity = transition_matrix(initialIdx,find(transition_matrix(initialIdx,:)~=0));
            vectorStates = randsample(possibleState, 10, true, probabilitity);
            idxNextState = randi(length(vectorStates));
            nextState = vectorStates(idxNextState);
            text = strcat(text," ",cellstr(nextState));
            initialWord = nextState;
    end 

text

