%% Record

% Set parameters
fs = 44100; % Sampling frequency
duration = 5; % Recording duration in seconds

% Record first stereo audio
recObj1 = audiorecorder(fs, 16, 2); % 16 bits per sample, 2 channels
disp('Start speaking for audio 1...');
recordblocking(recObj1, duration);
disp('End of recording for audio 1');

% Record second stereo audio
recObj2 = audiorecorder(fs, 16, 2);
disp('Start speaking for audio 2...');
recordblocking(recObj2, duration);
disp('End of recording for audio 2');

% Record third stereo audio
recObj3 = audiorecorder(fs, 16, 2);
disp('Start speaking for audio 3...');
recordblocking(recObj3, duration);
disp('End of recording for audio 3');

% Get the recorded audio data
stereoAudio1 = getaudiodata(recObj1);
stereoAudio2 = getaudiodata(recObj2);
stereoAudio3 = getaudiodata(recObj3);

% Plot the recorded stereo audio signals
time = (0:1/fs:(length(stereoAudio1)-1)/fs);
figure;

subplot(3, 1, 1);
plot(time, stereoAudio1(:, 1));
title('Audio 1');
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(time, stereoAudio2(:, 1));
title('Audio 2');
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(3, 1, 3);
plot(time, stereoAudio3(:, 1));
title('Audio 3 ');
xlabel('Time (seconds)');
ylabel('Amplitude');




%% Spectrogram 
% Plot spectrogram for the recorded audio signal
figure;

subplot(3, 1, 1);
spectrogram(stereoAudio1(:, 1), hann(256), 128, 1024, fs, 'yaxis');
title('Spectrogram 1');
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
%ylim([0 8000]); this would make it invisible

subplot(3, 1, 2);
spectrogram(stereoAudio2(:, 1), hann(256), 128, 1024, fs, 'yaxis');
title('Spectrogram 2');
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
%ylim([0 8000]); this would make it invisible

subplot(3, 1, 3);
spectrogram(stereoAudio3(:, 1), hann(256), 128, 1024, fs, 'yaxis');
title('Spectrogram 3');
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
%ylim([0 8000]); this would make it invisible



%% Save and Load WAV Files
% Save the recorded audio to a WAV file
audiowrite('stereo_audio_1.wav', stereoAudio1, fs);
audiowrite('stereo_audio_2.wav', stereoAudio2, fs);
audiowrite('stereo_audio_3.wav', stereoAudio3, fs);



% Plot the spectrograms for each  audio signal
figure;

subplot(3, 1, 1);
spectrogram(stereoAudio1(:, 1), hann(256), 128, 1024, fs, 'yaxis');
title('Spectrogram 1, Loading File');
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');

subplot(3, 1, 2);
spectrogram(stereoAudio2(:, 1), hann(256), 128, 1024, fs, 'yaxis');
title('Spectrogram 1, Loading File');
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');

subplot(3, 1, 3);
spectrogram(stereoAudio3(:, 1), hann(256), 128, 1024, fs, 'yaxis');
title('Spectrogram 3, Loading File');
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');


%% Calculate part 1 of last sectionn
% Constants
speedOfSound = 343; % Speed of sound in air (m/s)
sampleRate = 44100; % Sample rate of your audio device (samples/s)

distanceBetweenEarsMeters = 0.1; 

% Calculate Time Delay (seconds)
timeDelay = distanceBetweenEarsMeters / speedOfSound;

% Convert Time Delay to Milliseconds
timeDelayMillis = timeDelay * 1000;

% Calculate Number of Samples
numSamples = timeDelay * sampleRate;

% Display results
disp('Distance between Ear Canals (meters):');
disp(distanceBetweenEarsMeters);

disp('Time Delay (ms):');
disp(timeDelayMillis);

disp('Number of Samples:');
disp(numSamples);


% Load your stereo audio recording (replace 'your_audio_file.wav' with the actual filename)
[y, fs] = audioread('stereo_audio_1.wav');

% Extract left and right channels
L = y(:, 1);
R = y(:, 2);

% Display the original stereo audio
sound(y, fs);

% Create a stereo sound file with zero delay
audiowrite('TD-stereosoundfile-0ms.wav', [L, R], fs);

% Insert zeros at the beginning of the right channel and remove entries at the end
delaySamples = round(numSamples); % Replace with the calculated average number of samples
R_delayed_avg = [zeros(delaySamples, 1); R(1:end-delaySamples)];

% Save the stereo sound file with average head delay
audiowrite('TD-stereosoundfile-avghead.wav', [L, R_delayed_avg], fs);

% Delay the right channel by 1ms, 10ms, and 100ms
delay_1ms = round(0.001 * fs);
delay_10ms = round(0.01 * fs);
delay_100ms = round(0.1 * fs);

R_delayed_1ms = [zeros(delay_1ms, 1); R(1:end-delay_1ms)];
R_delayed_10ms = [zeros(delay_10ms, 1); R(1:end-delay_10ms)];
R_delayed_100ms = [zeros(delay_100ms, 1); R(1:end-delay_100ms)];

% Save the stereo sound files with different delays
audiowrite('TD-stereosoundfile-1ms.wav', [L, R_delayed_1ms], fs);
audiowrite('TD-stereosoundfile-10ms.wav', [L, R_delayed_10ms], fs);
audiowrite('TD-stereosoundfile-100ms.wav', [L, R_delayed_100ms], fs);


% Load 
[y, fs] = audioread('stereo_audio_1.wav');

% Extract left and right channels
L = y(:, 1);
R = y(:, 2);

% Display the original stereo audio
sound(y, fs);

% Create a stereo sound file with zero delay
audiowrite('TD-stereosoundfile-0ms.wav', [L, R], fs);

% Insert zeros at the beginning of the right channel and remove entries at the end
delaySamples = round(numSamples); % Replace with the calculated average number of samples
R_delayed_avg = [zeros(delaySamples, 1); R(1:end-delaySamples)];

% Save the stereo sound file with average head delay
audiowrite('TD-stereosoundfile-avghead.wav', [L, R_delayed_avg], fs);

% Apply attenuation to the right channel
attenuation_0dB = 1.0;
attenuation_minus_1_5dB = 10^(-1.5 / 20);
attenuation_minus_3dB = 10^(-3 / 20);
attenuation_minus_6dB = 10^(-6 / 20);

% Apply attenuation to the 0ms delay audio
R_attenuated_0dB = R;
R_attenuated_minus_1_5dB = attenuation_minus_1_5dB * R;
R_attenuated_minus_3dB = attenuation_minus_3dB * R;
R_attenuated_minus_6dB = attenuation_minus_6dB * R;

% Save the stereo sound files with different attenuations
audiowrite('TD-stereosoundfile-0ms.wav', [L, R_attenuated_0dB], fs);
audiowrite('TD-stereosoundfile-0ms-1_5dB.wav', [L, R_attenuated_minus_1_5dB], fs);
audiowrite('TD-stereosoundfile-0ms-3dB.wav', [L, R_attenuated_minus_3dB], fs);
audiowrite('TD-stereosoundfile-0ms-6dB.wav', [L, R_attenuated_minus_6dB], fs);

% Apply attenuation to the average head delay audio
R_delayed_avg_attenuated_0dB = R_delayed_avg;
R_delayed_avg_attenuated_minus_1_5dB = attenuation_minus_1_5dB * R_delayed_avg;
R_delayed_avg_attenuated_minus_3dB = attenuation_minus_3dB * R_delayed_avg;
R_delayed_avg_attenuated_minus_6dB = attenuation_minus_6dB * R_delayed_avg;

% Save the stereo sound files with different attenuations for average head delay
audiowrite('TD-stereosoundfile-avghead.wav', [L, R_delayed_avg_attenuated_0dB], fs);
audiowrite('TD-stereosoundfile-avghead-1_5dB.wav', [L, R_delayed_avg_attenuated_minus_1_5dB], fs);
audiowrite('TD-stereosoundfile-avghead-3dB.wav', [L, R_delayed_avg_attenuated_minus_3dB], fs);
audiowrite('TD-stereosoundfile-avghead-6dB.wav', [L, R_delayed_avg_attenuated_minus_6dB], fs);


