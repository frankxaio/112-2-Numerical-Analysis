% Function to plot the power spectrum
function plot_power_spectrum(signal, Fs, modulation_name)
    N = length(signal);
    f = Fs/2*linspace(0,1,N/2+1);
    
    Y = fft(signal);
    Y = Y(1:N/2+1);
    power_spectrum = (1/(Fs*N)) * abs(Y).^2;
    power_spectrum(2:end-1) = 2*power_spectrum(2:end-1);
    
    plot(f, 10*log10(power_spectrum));
    xlabel('Frequency (Hz)');
    ylabel('Power Spectrum (dB)');
    xlim([0 Fs/2]);
    grid on;
end