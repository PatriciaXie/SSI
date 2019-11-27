function scores = searchAngle(imgPatch, flyShadows)
    N = length(flyShadows);
    normalizeFator = size(imgPatch, 1)*size(imgPatch, 2);
    ds = zeros(N, 1);
    for i = 1:1:N
        ds(i) = sum( sum( abs(imgPatch - flyShadows{i}) ) )/normalizeFator;
    end
    scores = ds;
end