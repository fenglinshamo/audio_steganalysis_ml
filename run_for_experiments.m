bitrates = [128, 320];
widths = [2, 3, 4, 5];
feature_types = {'ADOTP', 'MDI2', 'JPBC'};
fp=fopen('EECS_results_EECS.txt','a');

[QMDCT_num, files_num] = deal(400, 2000);

cover_files_dir = 'E:\Myself\2.database\3.cover\cover_10s\';
stego_files_dir = 'E:\Myself\2.database\4.stego\EECS\';

for b = 1:length(bitrates)
    %% load QMDCT coefficients
    QMDCT_files_path_cover = [cover_files_dir, num2str(bitrates(b))];
    QMDCT_matrices_cover = qmdct_extraction_batch1(QMDCT_files_path_cover, QMDCT_num, files_num);
    
    for w = 1:length(widths)
       %% load QMDCT coefficients
        QMDCT_files_path_stego = [stego_files_dir, 'EECS_B_', num2str(bitrates(b)), '_W_', num2str(widths(w)), '_H_7_ER_10'];
        QMDCT_matrices_stego = qmdct_extraction_batch1(QMDCT_files_path_stego, QMDCT_num, files_num);
        
        %% feature extraction
        for f = 1:length(feature_types)
            % feature type: ADOTP(Jin), MDI2(Ren), JPBC(Wang-IS), I2C(Wang-CIHW), D2MA(Qiao), Occurance(Yan)
            feature_type = feature_types{f};
            feature_cover = feature_extraction_batch(QMDCT_matrices_cover, feature_type);
            feature_stego = feature_extraction_batch(QMDCT_matrices_stego, feature_type);

           %% train and validation
            % classifier type: svm, ensemble_classifier
            classifier_type = 'ensemble_classifier';
            [percent, times, ACC_sum] = deal(0.6, 50, 0);

            if strcmp(classifier_type, 'svm')
                try
                    for i = 1:times
                        [result, model] = training_svm(feature_cover, feature_stego, 0.6);
                        ACC_sum = ACC_sum + result.ACC;
                    end
                catch
                    fprintf('SVM Training Error.\n');
                end
            elseif strcmp(classifier_type, 'ensemble_classifier')
                try
                    for i = 1:times
                        [result, trained_ensemble] = training_ensemble(feature_cover, feature_stego, 0.6);
                        ACC_sum = ACC_sum + result.ACC;
                    end
                catch
                    fprintf('Ensemble Training Error.\n');
                end
            else
                fprintf('Error in classifier selection.\n');
                ACC = 0;
            end

            ACC_average = ACC_sum / times;
            fprintf('feature type: %s\n', feature_type);
            fprintf('Average Accuracy: %4.2f%%\r\n', 100*ACC_average);
            fprintf(fp,'feature_type: %s, bitrate: %d, width: %d, Accuracy: %.2f\r\n', feature_type, bitrates(b), widths(w), 100*ACC_average);
        end
    end
end
fclose(fp);