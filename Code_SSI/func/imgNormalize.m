function patch = imgNormalize(patch)
    minp = min(patch(:)); maxp = max(patch(:));
    if minp < maxp
        patch = (patch - minp)/(maxp-minp);
    end
end