clear;

% need to write code to separate input and output datasets
fileID = fopen('Training Data\optdigits-orig.windep');

num_features = 32 * 32;
data = zeros(num_features, 1797);
labels = zeros(1, 1797);

for i=1:21
    line = fgetl(fileID);
    %fprintf(line);
end

line = '';

label_num = 1;
while ~feof(fileID)
    image_matrix = zeros(32, 32);  % Initialize as a 32x32 matrix

    for i=1:32
        current_line = fgetl(fileID);
        new_line = zeros(1, length(current_line));  % Preallocate for speed
        
        for j=1:length(current_line)
            character = current_line(j);
            new_line(j) = double(character) - double('0');
        end
    
        image_matrix(i, :) = new_line;  % Assign new line as a row
    end

    image_matrix = reshape(image_matrix, [num_features, 1]);  % Reshape to 1024x1 vector
    data(:, label_num) = image_matrix;  % Assign to data matrix

    labels(label_num) = double(strtrim(fgetl(fileID))) - double('0'); 
    label_num = label_num + 1;
end

fclose(fileID);

labels_for_training = labels + 1;
num_classes = max(labels_for_training);  % Assuming labels are 1, 2, ..., num_classes
target_data = full(sparse(labels_for_training, 1:length(labels_for_training), 1, num_classes, length(labels_for_training)));

%printf(labels);
fprintf('Data input complete.');

