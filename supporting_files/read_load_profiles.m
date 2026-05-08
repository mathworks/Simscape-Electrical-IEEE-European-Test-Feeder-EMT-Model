loadProfile = zeros(1440,55);

for x = 1:55

    nx = num2str(x);

    qq = readtable(['Load_profile_',nx,'.csv']);

    loadProfile(:,x) = qq.mult;

    clear qq

end

clear x nx